require 'ripper_helper'
require_relative '../../../lib/raffle/refactorings/remove_unused_temp'
require 'raffle/recorder'

describe Raffle::Refactorings::RemoveUnusedTemp do
  let(:input) { <<CODE }
def thing
  fred = 35
  42
end
CODE

  it 'returns an s-expression with the temp removed' do
    refactor(input, '2,2-2,5', Raffle::Recorder.new).should == <<-EXPECTED
def thing
  42
end
    EXPECTED
  end

  context 'when the temp is not found' do
    it 'returns an error' do
      pending "can't quite make the remove temp fail yet - need a better check to make sure the extent selects a temp not just an ident"
      recorder = Raffle::Recorder.new
      refactor(input, '1,0-1,2', recorder)
      recorder.result.should be_a(Raffle::FailedResult)
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

    it 'returns and error'
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

    it 'removes the temp from the first method, leaving the second method unchanged' do
      refactor(input, '2,2-2,5', Raffle::Recorder.new).should == <<-CODE
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
