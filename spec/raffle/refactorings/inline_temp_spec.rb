require 'ripper_helper'
require_relative '../../../lib/raffle/refactorings/inline_temp'

describe Raffle::Refactorings::InlineTemp do
  it 'returns an s-expression with the temp inlined' do
    input = %{
    def thing
      fred = 35
      june = fred
    end
    }
    output = refactor(input, "fred")
    output.should == "def thing\nfred = 35\njune = 35\nend"
  end

  context 'when the temp is mutated' do
    # e.g.
    # def foo
    #   name = "fred"
    #   name << " is "
    #   "#{name} ace"
    # end
    example 'what should we do?'
  end
end
