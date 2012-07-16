require 'ripper_helper'
require 'string_helper'
require_relative '../../../lib/raffle/refactorings/remove_unused_temp'
require 'raffle/recorder'

describe Raffle::Refactorings::RemoveUnusedTemp do
  let(:input) do
    <<-CODE.undent
      def thing
        fred = 35
        42
      end
    CODE
  end

  it 'returns an s-expression with the temp removed' do
    expected = <<-CODE.undent
      def thing
        42
      end
    CODE
    refactor(input, '2,2-2,5', Raffle::Recorder.new).should == expected
  end

  context 'when the temp is not found' do
    it 'returns an error' do
      pending "can't quite make the rename temp fail yet - need a better check to make sure the extent selects a temp not just an ident"
      recorder = Raffle::Recorder.new
      refactor(input, '1,0-1,2', recorder)
      recorder.result.should be_a(Raffle::FailedResult)
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
