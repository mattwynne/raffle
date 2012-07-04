require 'ripper'
require 'sorcerer'

module RipperHelper
  def refactor(input, *args)
    sexp = convert(input)
    result = subject.call(sexp, *args)
    rubify(result)
  end

  def convert(source)
    Ripper::SexpBuilder.new(source).parse
  end

  def rubify(sexpr)
    Sorcerer.source(sexpr, multiline: true)
  end
end

RSpec.configure do |c|
  c.include RipperHelper
end
