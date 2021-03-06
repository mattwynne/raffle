# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'raffle/version'

Gem::Specification.new do |s|
  s.name        = 'raffle'
  s.version     = Raffle::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Wynne", "Chris Parsons", "Jim Weirich", "Steve Tooke", "Stuart Gale", "Kevin Rutherford"]
  s.email       = ["a-refactoring-tool-for-ruby@googlegroups.com"]
  s.summary     = "A refactoring tool for ruby."
  s.description = <<-DESCRIPTION
    Raffle is a command-line tool for refactoring Ruby programs.
  DESCRIPTION
  s.homepage    = "https://github.com/mattwynne/raffle"

  s.add_dependency 'sorcerer', '~> 0.3.2'
  s.add_development_dependency 'rspec',    '~> 2.10.0'
  s.add_development_dependency 'rake',     '~> 0.9.2.2'
  s.add_development_dependency 'cucumber', '~> 1.2'
  s.add_development_dependency 'aruba',    '~> 0.4'
end
