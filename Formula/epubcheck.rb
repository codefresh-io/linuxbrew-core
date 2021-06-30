class Epubcheck < Formula
  desc "Validate EPUB files, version 2.0 and later"
  homepage "https://github.com/w3c/epubcheck"
  url "https://github.com/w3c/epubcheck/releases/download/v4.2.6/epubcheck-4.2.6.zip"
  sha256 "3f73c1265cc92e3b53ffda6cd5bbeb58505b2b0c43411c26e74d8df1b193b2c0"
  license "BSD-3-Clause"

  depends_on "openjdk"

  def install
    jarname = "epubcheck.jar"
    libexec.install jarname, "lib"
    bin.write_jar_script libexec/jarname, "epubcheck"
  end
end
