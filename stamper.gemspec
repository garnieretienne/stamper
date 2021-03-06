# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stamper/version'

Gem::Specification.new do |spec|
  spec.name          = "stamper"
  spec.version       = Stamper::VERSION
  spec.authors       = ["Etienne Garnier"]
  spec.email         = ["garnier.etienne@gmail.com"]
  spec.description   = %q{EMail reader library}
  spec.summary       = %q{Simple mailboxes browser and email reader library}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mail"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "debugger"
end
