require 'ripper'
require 'sorcerer'
require 'raffle/extent'
require 'raffle/recorder'

module RipperHelper
  def refactor(input, extent_string, *args)
    sexp = convert(input)
    extent = Raffle::Extent.parse(extent_string)
    extent_sexp = extent.slice(input)
    result = subject.call(sexp, extent, extent_sexp, *args)
    rubify(result)
  end

  def convert(source)
    Ripper::SexpBuilder.new(source).parse
  end

  def rubify(sexpr)
    Sorcerer.source(sexpr, indent: true)
  end
end

RSpec.configure do |c|
  c.include RipperHelper
end
