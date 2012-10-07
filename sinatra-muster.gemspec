# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/muster/version'

Gem::Specification.new do |gem|
  gem.name          = "sinatra-muster"
  gem.version       = Sinatra::Muster::VERSION
  gem.authors       = ["Christopher H. Laco"]
  gem.email         = ["claco@chrislaco.com"]
  gem.description   = %q{Extension and Helpers for using Muster in Sinatra applications.}
  gem.summary       = %q{Sinatra Muster Exception}
  gem.homepage      = "https://github.com/claco/sinatra-muster"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'muster', '>= 0.0.4'
  gem.add_dependency 'sinatra'

  gem.add_development_dependency 'rspec',     '~> 2.11.0'
  gem.add_development_dependency 'redcarpet', '~> 2.1'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'yard',      '~> 0.8.2'  
  gem.add_development_dependency 'rack-test'
end
