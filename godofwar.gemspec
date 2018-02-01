# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'godofwar'

Gem::Specification.new do |spec|
  spec.name          = "godofwar"
  spec.version       = GodOfWar::VERSION
  spec.authors       = ["KING SABRI | @KINGSABRI"]
  spec.email         = ["king.sabri@gmail.com"]

  spec.summary       = %q{Evil war builder for hackers with some built-in war files.}
  spec.description   = %q{Evil war builder for hackers with some built-in war files.}
  spec.homepage      = "https://github.com/TechArchSA/godofwar"
  spec.license       = "MIT"

  spec.add_dependency 'rubyzip'

  spec.files         = Dir.glob("**/*")
  spec.bindir        = "bin"
  spec.executables   = %{godofwar}
  spec.require_paths = ["lib"]

  spec.post_install_message = GodOfWar::Utils.logo
end
