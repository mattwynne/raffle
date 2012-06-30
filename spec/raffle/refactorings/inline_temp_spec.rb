require 'ripper'
require 'sorcerer'
require 'awesome_print'
require_relative '../../../lib/raffle/refactorings/inline_temp'

describe Raffle::Refactorings::InlineTemp do
  it 'returns an s-expression with the temp inlined' do
    input = %{
    def thing
      fred = 35
      june = fred
    end
    }
    sexp = convert(input)
    result = subject.call(sexp, "fred")
    rubify(result).should == 
      'def thing fred = 35; june = 35; end'
  end

  def convert(source)
    Ripper::SexpBuilder.new(source).parse
  end

  def rubify(sexpr)
    Sorcerer.source(sexpr)
  end
end
