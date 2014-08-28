# -*- encoding: utf-8 -*-
require File.expand_path('../lib/adminlte-rails/version', __FILE__)
Gem::Specification.new do |s|
  s.name = 'adminlte-rails'
  s.version = AdminLTE::Rails::VERSION
  s.authors = ['Nguyen Ba Dung']
  s.email = ['nguyenbadung@gmail.com']
  s.homepage = 'https://github.com/shine60vn/adminlte-rails'
  s.summary = %q{Integrates the AdminLTE theme with the Rails asset pipeline}
  s.description = %q{AdminLTE is a premium Bootstrap theme for Backend.}
  s.license = 'MIT'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.add_dependency 'thor', '~> 0.14'
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rails', '>= 3.0'
  s.add_development_dependency 'httpclient', '~> 2.2'
  s.add_development_dependency 'byebug'
end