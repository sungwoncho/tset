# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tset/version'

Gem::Specification.new do |spec|
  spec.name          = "tset"
  spec.version       = Tset::VERSION
  spec.authors       = ["Sung Won Cho"]
  spec.email         = ["mikeswcho@gmail.com"]
  spec.summary       = %q{Generate tests for your Rails model.}
  spec.description   = %q{Generate tests for your Rails model. Enter Development Driven Test.}
  spec.homepage      = "https://github.com/sungwoncho/tset"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"

  spec.add_dependency "thor", "~> 0.19.1"
  spec.add_dependency "activesupport", "~> 4.2.1"
end
