class Gbdfed < Formula
  desc "Bitmap Font Editor"
  homepage "http://sofia.nmsu.edu/~mleisher/Software/gbdfed/"
  url "http://sofia.nmsu.edu/~mleisher/Software/gbdfed/gbdfed-1.6.tar.gz"
  sha256 "8042575d23a55a3c38192e67fcb5eafd8f7aa8d723012c374acb2e0a36022943"
  revision 3

  livecheck do
    url :homepage
    regex(/href=.*?gbdfed[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "636d528318fa5e5fc90bdc61665ca3e3dc220a5c034bb478bedda854017de83d"
    sha256 cellar: :any, big_sur:       "0c060efda560aa9ab6addc8087cad336ca01f420b280f0e41b2460f4d74b06aa"
    sha256 cellar: :any, catalina:      "ac131ff87dd812928b3f8136d5ce364370ab0a8ded3ffdf2fbf2a38e58998494"
    sha256 cellar: :any, mojave:        "00b2376a043f6e90d777bc9e5805d84da21c046f446c4dcd649b482a01cbc6cf"
    sha256 cellar: :any, high_sierra:   "945fc3ffa7573224e7a387e6dec353ca7f3b46829f3e3728774a97c26fb0923a"
    sha256 cellar: :any, sierra:        "e32f2b72805a1dbe768f85e33ea10c0b603789f9101b21e0fbc750ab077a12e5"
    sha256 cellar: :any, x86_64_linux:  "b94225ed5534f6560fcf757a1c4ed3c27e55d20c52e958610e9010dbd75f9a0f" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "gtk+"

  # Fixes compilation error with gtk+ per note on the project homepage.
  patch :DATA

  def install
    # BDF_NO_X11 has to be defined to avoid X11 headers from being included
    ENV["CPPFLAGS"] = "-DBDF_NO_X11"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--without-x"
    system "make", "install"
  end

  test do
    assert_predicate bin/"gbdfed", :exist?
    assert_predicate share/"man/man1/gbdfed.1", :exist?
  end
end

__END__
diff --git a/Makefile.in b/Makefile.in
index b482958..10a528e 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -28,8 +28,7 @@ CC = @CC@
 CFLAGS = @XX_CFLAGS@ @CFLAGS@
 
 DEFINES = @DEFINES@ -DG_DISABLE_DEPRECATED \
-	-DGDK_DISABLE_DEPRECATED -DGDK_PIXBUF_DISABLE_DEPRECATED \
-	-DGTK_DISABLE_DEPRECATED
+	-DGDK_PIXBUF_DISABLE_DEPRECATED
 
 SRCS = bdf.c \
        bdfcons.c \
