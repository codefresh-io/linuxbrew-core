class Dupseek < Formula
  desc "Interactive program to find and remove duplicate files"
  homepage "http://www.beautylabs.net/software/dupseek.html"
  url "http://www.beautylabs.net/software/dupseek-1.3.tgz"
  sha256 "c046118160e4757c2f8377af17df2202d6b9f2001416bfaeb9cd29a19f075d93"
  license "GPL-2.0-only"

  livecheck do
    url :homepage
    regex(/href=.*?dupseek[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b82a513c1aa616e8f6ea6f8c621355815381d6b0315c85f5956c08aea7c7493f"
    sha256 cellar: :any_skip_relocation, big_sur:       "5dd4ba8f61d6e17de45eed186601e3d90b84515a6971520cf38be3d94888ee4f"
    sha256 cellar: :any_skip_relocation, catalina:      "aca5de3c9426773cb4ae19e791bb8662fd55b5f56075c2120d850d5228176a19"
    sha256 cellar: :any_skip_relocation, mojave:        "e06fc46656cf29f29a33a198a011a022753e616b03e36dfee9cf1ade5c4ab227"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3474d09c5989f98afcd59d1859a9aef933e9af9040a44d58601ec0ea7397561e" # linuxbrew-core
  end

  def install
    bin.install "dupseek"
    doc.install %w[changelog.txt doc.txt copyright credits.txt]
  end

  test do
    mkdir "folder"
    touch "folder/file1"
    assert_equal "", shell_output("#{bin}/dupseek -b report -f de folder").chomp
    touch "folder/file2"
    assert_match %r{^folder\\/file[12]$}, shell_output("#{bin}/dupseek -b report -f de folder").chomp
    assert_equal "folder\\/file1\nfolder\\/file2", shell_output("#{bin}/dupseek -b report -f e folder | sort").chomp
  end
end
