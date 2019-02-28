class Confd < Formula
    desc "Manage local application configuration files using templates and data from etcd or consul"
    homepage "https://github.com/kelseyhightower/confd"
    url "https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-darwin-amd64"
    version "0.16.0"
    sha256 "2f919dc4c33eac98faf165226a5a5381ce8dc8445d0925ccd61f9cb1c01d4932"
  
    def install
      bin.install "confd-0.16.0-darwin-amd64"
      mv bin/"confd-0.16.0-darwin-amd64", bin/"confd"
    end
  end