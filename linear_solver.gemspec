# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'linear_solver/version'

Gem::Specification.new do |spec|
  spec.name          = "linear_solver"
  spec.version       = LinearSolver::VERSION
  spec.authors       = ["stantoncbradley"]
  spec.email         = ["stantoncbradley@gmail.com"]
  spec.summary       = ["Brute force solve equations in log(n) time"]
  spec.description   = ["For y = f(x), given y, solves for x."]
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
end
