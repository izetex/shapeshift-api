# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shapeshift/api/version'

Gem::Specification.new do |spec|
  spec.name          = "shapeshift-api"
  spec.version       = Shapeshift::Api::VERSION
  spec.authors       = ["astudnev"]
  spec.email         = ["astudnev@gmail.com"]

  spec.summary       = %q{Shapeshift crypto exchange API wrapper.}
  spec.description   = %q{Allows transfer one crypto currency into another.}
  spec.homepage      = "https://izx.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
