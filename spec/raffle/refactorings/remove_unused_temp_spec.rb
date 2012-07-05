require 'ripper_helper'
require_relative '../../../lib/raffle/refactorings/remove_unused_temp'

describe Raffle::Refactorings::RemoveUnusedTemp do
  let(:input) do
    <<CODE
def thing
  fred = 35
  42
end
CODE
  end

  it 'returns an s-expression with the temp removed' do
    expected = <<CODE
def thing
  42
end
CODE
    refactor(input, 'fred').should == expected
  end

  context 'when the temp is not found' do
    it 'returns the s-expression unchanged' do
      refactor(input, 'jim').should == "def thing\n  fred = 35\n  42\nend\n"
    end
  end

  context 'when the temp is used' do
    it 'returns the s-expression unchanged' do
      pending "how do we know if a variable is used?"
    end

  end

  context 'when the temp is the return value' do
    it 'returns the original return value'
  end
end
