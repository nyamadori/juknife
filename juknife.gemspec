# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'juknife/version'

Gem::Specification.new do |spec|
  spec.name          = 'juknife'
  spec.version       = Juknife::VERSION
  spec.authors       = ['nyamadori']
  spec.email         = ['nyamadorig@gmail.com']

  spec.summary       = 'A scraping library for Ruby and Ruby on Rails'
  spec.description   = 'A scraping library for Ruby and Ruby on Rails'
  spec.homepage      = 'https://github.com/nyamadori/juknife'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 5.0.2'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end