require 'formula'

class Upx < Formula
  desc "Compress/expand executable files"
  homepage "https://upx.github.io/"
  url "https://github.com/upx/upx/releases/download/v4.0.1/upx-4.0.1-src.tar.xz"
  sha256 "77003c8e2e29aa9804e2fbaeb30f055903420b3e01d95eafe01aed957fb7e190"
  license "GPL-2.0-or-later"
  revision 1
  head "https://github.com/upx/upx.git", branch: "devel"

  depends_on "ucl" => :build

  uses_from_macos "zlib"

  def install
    system "make", "all"
    bin.install "src/upx.out" => "upx"
    man1.install "doc/upx.1"
  end

  test do
    cp "#{bin}/upx", "."
    chmod 0755, "./upx"

    system "#{bin}/upx", "-1", "./upx"
    system "./upx", "-V" # make sure the binary we compressed works
    system "#{bin}/upx", "-d", "./upx"
  end
end
