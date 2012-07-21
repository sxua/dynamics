# -*- coding: utf-8 -*-

require 'rake'

Gem::Specification.new do |s|
  s.name        = 'dynamics'
  s.version     = '0.0.7'
  s.executables = 'dynamics'
  s.date        = '2012-07-21'
  s.summary     = "A framework for RubyMotion."
  s.description = "A framework for developing RubyMotion applications quickly."
  s.authors     = ["Ng Say Joe"]
  s.email       = 'ngsayjoe@gmail.com'
  s.files       = FileList["lib/*.rb", "base/Rakefile", "base/**/*.rb"].to_a
  s.homepage    = 'http://www.dynamics.io/'
end