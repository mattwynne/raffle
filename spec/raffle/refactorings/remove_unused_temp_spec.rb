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
      refactor(input, 'fred').should == "def thing\n42\nend"
    end

    context 'when the temp is not found' do
      it 'returns the s-expression unchanged' do
        refactor(input, 'jim').should == "def thing\nfred = 35\n42\nend"
      end
    end
  end

  context 'when the temp is used within the same method scope' do
    it 'returns the s-expression unchanged' do
      input = %{
        def thing
          fred = 35
          do_something_to fred
          42
        end
      }

      refactor(input, 'fred').should ==
        "def thing\nfred = 35\ndo_something_to fred\n42\nend"
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
      refactor(input, 'fred').should == <<-CODE
def thing
42
end

def fred
"something unrelated"
end
      CODE
    end
  end

  context 'when the temp is the return value' do
    it 'returns the original return value'
  end
end
