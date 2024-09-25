# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/canva/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-canva'
  spec.version       = Omniauth::Canva::VERSION
  spec.authors       = ['Bizplay']
  spec.email         = ['info@bizplay.com']
  spec.summary       = %q{omniauth provider for Canva API}
  spec.description   = %q{omniauth provider for Canva API}
  spec.homepage      = 'https://github.com/bizplay/canva'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth-oauth2'
end
