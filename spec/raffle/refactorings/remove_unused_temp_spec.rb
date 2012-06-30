require 'ripper'
require 'sorcerer'
require 'awesome_print'
require_relative '../../../lib/raffle/refactorings/remove_unused_temp'

describe Raffle::Refactorings::RemoveUnusedTemp do
  it 'returns an s-expression with the temp removed' do
    input = %{
    def thing
      fred = 35
    end
    }
    refactor(input, 'fred').should == 'def thing ; end'
  end

  context 'when the temp is not found' do
    it 'returns the s-expression unchanged'
  end

  context 'when the temp is used' do
    it 'returns the s-expression unchanged'
  end

  def refactor(input, *args)
    sexp = convert(input)
    result = subject.call(sexp, *args)
    rubify(result)
  end

  def convert(source)
    Ripper::SexpBuilder.new(source).parse
  end

  def rubify(sexpr)
    Sorcerer.source(sexpr)
  end
end
