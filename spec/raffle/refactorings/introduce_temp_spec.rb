require 'ripper_helper'
require_relative '../../../lib/raffle/refactorings/introduce_temp'

describe Raffle::Refactorings::IntroduceTemp do
  it 'extracts the selected code as a temp' do
    pending('discussion of how we select an area of text')
    input = %{
    def thing
      june = 35
    end
    }

    # should we passing in line number, column number, as well?
    output = refactor(input, convert('35'), 'fred')

    output.should == "def thing\nfred = 35\njune = fred\nend"
  end
end
