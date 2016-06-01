lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'betaface/version'

Gem::Specification.new do |s|
  s.name                     = 'betaface'
  s.version                  = Betaface::VERSION
  s.date                     = '2016-06-02'
  s.files                    = `git ls-files -z`.split("\x0")
  s.require_paths            = ['lib']
  s.summary                  = "Use the betaface API with Ruby!"
  s.description              = "A ruby Gem to easily use the betaface API without having to deal with all this XLM"
  s.authors                  = ["Jean Meyer"]
  s.email                    = 'jean@getonce.com'
  s.homepage                 = 'http://rubygems.org/gems/betaface'
  s.license                  = 'MIT'
  s.required_ruby_version    = '>= 1.9.3'
  s.add_dependency('multi_json', '>= 1.3.0')
  s.add_dependency('rubysl') if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'rbx'
end
