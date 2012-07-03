require 'ripper_helper'
require_relative '../../../lib/raffle/refactorings/remove_unused_temp'

describe Raffle::Refactorings::RemoveUnusedTemp do
  let(:input) do
    %{
      def thing
        fred = 35
        42
      end
    }
  end

  it 'returns an s-expression with the temp removed' do
    refactor(input, 'fred').should == "def thing\n42\nend"
  end

  context 'when the temp is not found' do
    it 'returns the s-expression unchanged' do
      refactor(input, 'jim').should == "def thing\nfred = 35\n42\nend"
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
