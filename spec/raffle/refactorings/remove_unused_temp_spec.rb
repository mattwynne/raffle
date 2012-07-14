require 'ripper_helper'
require_relative '../../../lib/raffle/refactorings/remove_unused_temp'

describe Raffle::Refactorings::RemoveUnusedTemp do
  context 'when the temp is not used anywhere else in the same method' do
    let(:input) { <<-CODE }
def thing
  fred = 35
  42
end
CODE

    it 'removes the temp' do
      refactor(input, 'fred').should == <<CODE
def thing
  42
end
CODE
    end

    context 'when the temp is not found' do
      it 'returns the s-expression unchanged' do
        refactor(input, 'jim').should == <<CODE
def thing
  fred = 35
  42
end
CODE
      end
    end
  end

  context 'when the temp is used within the same method scope' do
    let(:input) { <<-CODE }
def thing
  fred = 35
  do_something_to fred
  42
end
CODE

    it 'returns the s-expression unchanged' do
      refactor(input, 'fred').should == input
    end
  end

  context "when the temp's name is used as the name of another method" do
    let(:input) { <<-CODE }
      def thing
        fred = 35
        42
      end

      def fred
        "something unrelated"
      end
    CODE

    it 'removes the temp from the first method' do
      refactor(input, 'fred').should == <<CODE
def thing
  42
end
def fred
  \"something unrelated\"
end
CODE
    end
  end

  context 'when the temp is the return value' do
    let (:input) { <<-CODE }
def thing
  fred = 35
  42
  fred
end
CODE

    it 'returns the original return value' do
      refactor(input, 'fred').should == input
    end
  end
end
