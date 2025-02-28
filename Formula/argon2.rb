class Argon2 < Formula
  desc "Password hashing library and CLI utility"
  homepage "https://github.com/P-H-C/phc-winner-argon2"
  url "https://github.com/P-H-C/phc-winner-argon2/archive/20190702.tar.gz"
  sha256 "daf972a89577f8772602bf2eb38b6a3dd3d922bf5724d45e7f9589b5e830442c"
  license "Apache-2.0"
  revision OS.mac? ? 1 : 2
  head "https://github.com/P-H-C/phc-winner-argon2.git", branch: "master"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "192f3381abe337df8af214cf4dccef2cbfaa9c88df489b5cf9276cea9f8c6080"
    sha256 cellar: :any, big_sur:       "a9dd363964a2a633ace13aff04e4c5eac7e720d44faf377456de55396647ff13"
    sha256 cellar: :any, catalina:      "f8e550c8597728bb9edc5a548497fd7b1219203932cd0f93ecc97a4fbf0bdad8"
    sha256 cellar: :any, mojave:        "a76192a41826619fc399e7f6de5e6cb1c8a5fbe6bea4f2c1554daa830fa0e296"
    sha256 cellar: :any, high_sierra:   "830016982e60870f50b3f6fc9a215d8cc4bda6061595f4883f7c11ab19ecba39"
    sha256 cellar: :any, sierra:        "21889ac6ed40c792f1b372b5aa0d6b3be1be86577a4c1b06b08569124d2d0da2"
    sha256 cellar: :any, x86_64_linux:  "d5a37785ef088eed38dc1f644878ab3e969f23e3801792f3f8da6a40f8a68a7e" # linuxbrew-core
  end

  def install
    system "make", "PREFIX=#{prefix}", "ARGON2_VERSION=#{version}", "LIBRARY_REL=lib"
    system "make", "test"
    system "make", "install", "PREFIX=#{prefix}", "ARGON2_VERSION=#{version}", "LIBRARY_REL=lib"
    doc.install "argon2-specs.pdf"
  end

  test do
    output = pipe_output("#{bin}/argon2 somesalt -t 2 -m 16 -p 4", "password")
    assert_match "c29tZXNhbHQ$IMit9qkFULCMA/ViizL57cnTLOa5DiVM9eMwpAvPw", output
  end
end
