# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ps_pabx_listener/version'

Gem::Specification.new do |spec|
  spec.name          = "ps_pabx_listener"
  spec.version       = PsPabxListener::VERSION
  spec.authors       = ["Lucas Vieira"]
  spec.email         = ["lucas@vieira.io"]

  spec.summary       = %q{Command line utility which connects to a Panasonic PABX via telnet and retrieve calling information.}
  spec.description   = %q{A command line utility which connects to a Panasonic PABX via *telnet* and retrieve calling information. Filters valuable content while keeping the original fixed-space format.}
  spec.homepage      = "http://vieira.io"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-mocks", "~> 3.0"
  spec.add_development_dependency "factory_girl", "~> 4.7"
end
