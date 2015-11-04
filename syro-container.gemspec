# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'syro/container/version'

Gem::Specification.new do |spec|
  spec.name          = "syro-container"
  spec.version       = Syro::Container::VERSION
  spec.authors       = ["Seba Gamboa"]
  spec.email         = ["me@sagmor.com"]

  spec.summary       = %q{A Syro extension to resolve paths from a container.}
  spec.description   = %q{A Syro extension to resolve paths from a container.}
  spec.homepage      = "https://github.com/sagmor/syro-container"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "syro"
  spec.add_runtime_dependency "dry-container"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
end
