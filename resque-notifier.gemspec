# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resque/notifier/version'

Gem::Specification.new do |spec|
  spec.name          = "resque-notifier"
  spec.version       = Resque::Notifier::VERSION
  spec.authors       = ["daveed"]
  spec.email         = ["david.alphen@gmail.com"]
  spec.summary       = %q{Send notifications when a resque job fails}
  spec.description   = %q{This Resque plugin sends a notification when a job fails}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
