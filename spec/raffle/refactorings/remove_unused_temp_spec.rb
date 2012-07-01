require 'ripper_helper'
require_relative '../../../lib/raffle/refactorings/remove_unused_temp'

describe Raffle::Refactorings::RemoveUnusedTemp do
  it 'returns an s-expression with the temp removed' do
    input = %{
    def thing
      fred = 35
    end
    }
    refactor(input, 'fred').should == "def thing\nend"
  end

  context 'when the temp is not found' do
    it 'returns the s-expression unchanged'
  end

  context 'when the temp is used' do
    it 'returns the s-expression unchanged'
  end
end
