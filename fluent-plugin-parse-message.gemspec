# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-parse-message"
  spec.version       = "0.0.1"
  spec.authors       = ["Matthew O'Riordan"]
  spec.email         = ["matt@ably.io "]
  spec.description   = %q{Filter to parse messages}
  spec.summary       = %q{Filter to parse messages}
  spec.homepage      = "https://github.com/mattheworiordan/fluent-plugin-parse-message"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_runtime_dependency "fluentd", "~> 0.14"
end
