require 'formula'

class Upx < Formula
  desc "Compress/expand executable files"
  homepage "https://upx.github.io/"
  url "https://github.com/upx/upx/releases/download/v5.0.1/upx-5.0.1-src.tar.xz"
  sha256 "2b11323a9f6c7f0247a4936deee35afb486a2fdf808a5bc4abf10a085ec884d9"
  license "GPL-2.0-or-later"
  revision 1
  head "https://github.com/upx/upx.git", branch: "devel"

  depends_on "ucl" => :build
  depends_on "cmake" => :build

  uses_from_macos "zlib"

  def install
    system "make"
    bin.install "build/release/upx" => "upx"
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
