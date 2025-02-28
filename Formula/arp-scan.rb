class ArpScan < Formula
  desc "ARP scanning and fingerprinting tool"
  homepage "https://github.com/royhills/arp-scan"
  url "https://github.com/royhills/arp-scan/archive/1.9.7.tar.gz"
  sha256 "e03c36e4933c655bd0e4a841272554a347cd0136faf42c4a6564059e0761c039"
  license "GPL-3.0"
  head "https://github.com/royhills/arp-scan.git", branch: "master"

  bottle do
    sha256 arm64_big_sur: "bab165d30f8039bba63d086234d0c57c64152fe73d586081dfaa7eec177fcefd"
    sha256 big_sur:       "f3fe2b4b1f70e09f79aaf43b2044068ce5431135a7d7e78ab5022202bfb48ab4"
    sha256 catalina:      "763b615392ea20ab1900bbc4a21fb0a9a978bbf50d3bbd8d5ff490437defc6f8"
    sha256 mojave:        "178196ab4312319611ad02c8e086e56fec2217981f9d91d9e7df8cddfeacda4e"
    sha256 high_sierra:   "f72f46496eecff4c1a86dbdbf3a295e195310827ef50cdc0b007bd7b6311495d"
    sha256 x86_64_linux:  "37a5e80f04e95b2a555318142289245fdde6c2ccb9433fd5c6f92cbff56ad9ad" # linuxbrew-core
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libpcap"

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/arp-scan", "-V"
  end
end
