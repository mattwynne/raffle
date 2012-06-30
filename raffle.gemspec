# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'raffle/version'

Gem::Specification.new do |s|
  s.name 'raffle'
  s.version Raffle::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Wynne", "Tom Crayford", "Stuart Gale", "Leo Cassanari"]
  s.email       = ["a-refactoring-tool-for-ruby@googlegroups.com"]
end
