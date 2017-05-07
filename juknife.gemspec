# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'juknife/version'

Gem::Specification.new do |spec|
  spec.name          = 'juknife'
  spec.version       = Juknife::VERSION
  spec.authors       = ['nyamadori']
  spec.email         = ['nyamadorig@gmail.com']

  spec.summary       = 'A Ruby library for Web scraping.'
  spec.description   = <<~DESC
    A Ruby library for Web scraping. It allows to describe scraping nodes and
    text structurally and declaratively.
  DESC
  spec.homepage      = 'https://github.com/nyamadori/juknife'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 5.0.2'
  spec.add_runtime_dependency 'nokogiri', '~> 1.7'
  spec.add_runtime_dependency 'faraday', '~> 0.1'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'pry'
end
