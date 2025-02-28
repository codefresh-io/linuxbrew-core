class Flex < Formula
  desc "Fast Lexical Analyzer, generates Scanners (tokenizers)"
  homepage "https://github.com/westes/flex"
  url "https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz"
  sha256 "e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995"
  license "BSD-2-Clause"
  revision 2

  bottle do
    sha256 arm64_big_sur: "ba78304da35f69526d386e1d1decca8818b155b4dda4f470d9393d23cf713e11"
    sha256 big_sur:       "89ec2b04b1aab94297f490c60fe6ca2bcde7de9b7661482728b07931e635d21c"
    sha256 catalina:      "e563a7a42aceff203cca4f420ebc6a8bbd5075a2b0007d46724f037ebc7b41a5"
    sha256 mojave:        "687132db0837bdcb6e02b5715f6a07f658bdf109b5353908f260d46d354f7bdb"
    sha256 x86_64_linux:  "eb465398252c2365bb899cc7cc42f1ca59dd47a7f6325d325c1362fd7a3b21b9" # linuxbrew-core
  end

  head do
    url "https://github.com/westes/flex.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build

    # https://github.com/westes/flex/issues/294
    depends_on "gnu-sed" => :build

    depends_on "libtool" => :build
    depends_on :macos
  end

  keg_only :provided_by_macos

  depends_on "help2man" => :build
  depends_on "gettext"

  uses_from_macos "bison" => :build
  uses_from_macos "m4"

  def install
    if build.head?
      ENV.prepend_path "PATH", Formula["gnu-sed"].opt_libexec/"gnubin"

      system "./autogen.sh"
    end

    # Fix segmentation fault during install on Ubuntu 18.04 (caused by glibc 2.26+),
    # remove with the next release
    ENV.append "CPPFLAGS", "-D_GNU_SOURCE" if OS.linux?

    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-shared",
                          "--prefix=#{prefix}"
    system "make", "install"
    bin.install_symlink "flex" => "lex"
  end

  test do
    (testpath/"test.flex").write <<~EOS
      CHAR   [a-z][A-Z]
      %%
      {CHAR}+      printf("%s", yytext);
      [ \\t\\n]+   printf("\\n");
      %%
      int main()
      {
        yyin = stdin;
        yylex();
      }
    EOS
    system "#{bin}/flex", "test.flex"
    system ENV.cc, "lex.yy.c", "-L#{lib}", "-lfl", "-o", "test"
    assert_equal shell_output("echo \"Hello World\" | ./test"), <<~EOS
      Hello
      World
    EOS
  end
end
