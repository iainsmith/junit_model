# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'junit_model/version'

Gem::Specification.new do |spec|
  spec.name          = "junit_model"
  spec.version       = JunitModel::VERSION
  spec.authors       = ["Iain Smith"]
  spec.email         = ["iain@mountain23.com"]

  spec.summary       = "A nicer way to deal with JUnit style xml"
  spec.homepage      = "https://www.github.com/iainsmith/junit_model"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "xml-simple", "1.1.5"
  spec.add_dependency "builder"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "terminal-notifier"
  spec.add_development_dependency "terminal-notifier-guard"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "guard-rubocop"
  spec.add_development_dependency "coveralls"
end
