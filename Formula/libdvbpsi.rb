class Libdvbpsi < Formula
  desc "Library to decode/generate MPEG TS and DVB PSI tables"
  homepage "https://www.videolan.org/developers/libdvbpsi.html"
  url "https://download.videolan.org/pub/libdvbpsi/1.3.3/libdvbpsi-1.3.3.tar.bz2"
  sha256 "02b5998bcf289cdfbd8757bedd5987e681309b0a25b3ffe6cebae599f7a00112"
  license "LGPL-2.1"

  livecheck do
    url "https://download.videolan.org/pub/libdvbpsi/"
    regex(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "a61aaac7ff201fdd38a929556c6a64a69993150891690f8ea9532e1b9c9c9ae3"
    sha256 cellar: :any, big_sur:       "255b960c43fac14b8a50af513ca3b2925cdfa0e71efa61d2eced2fd172fe8dff"
    sha256 cellar: :any, catalina:      "b6e6f300bbc36fabf785f74abb083c5cfc3f91fdd51ee7bd058cc579e709c78d"
    sha256 cellar: :any, mojave:        "26298540d01f52628385c83cac4b6666543af4cc059fa7ad5b3a8bd458955628"
    sha256 cellar: :any, high_sierra:   "c6d79686bf05346bc473cc148b68901d99ac447a85542ff68d089c71eda1bc87"
    sha256 cellar: :any, sierra:        "8bb1f1fff61674756153e8aec744d5d3c726da0c4ecd4bd291cae732e8264af3"
    sha256 cellar: :any, x86_64_linux:  "01a3895cbf26835d8cfca2b52db90e1a0ee39efed1662481489e74399ccbad7b" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking", "--enable-release"
    system "make", "install"
  end
end
