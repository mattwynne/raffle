require 'ripper_helper'
require_relative '../../../lib/raffle/refactorings/rename_temp'

describe Raffle::Refactorings::RenameTemp do
  it 'changes all occurrences of the temp name, but only within the given scope' do
    input = %{
      def foo
        fred = 45
        june = fred
      end

      def bar
        fred = "captain"
      end
    }
    output = refactor(input, 'fred', 'billy', [3,0])
    output.should == "def foo\nbilly = 45\njune = billy\nend"
  end

  context 'when the temp is a parameter'
end
