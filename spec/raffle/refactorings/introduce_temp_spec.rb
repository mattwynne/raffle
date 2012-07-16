require 'ripper_helper'
require 'string_helper'
require_relative '../../../lib/raffle/refactorings/introduce_temp'

describe Raffle::Refactorings::IntroduceTemp do
  it 'extracts the selected code as a temp' do
    pending('discussion of how we select an area of text')
    input = <<-CODE.undent
      def thing
        june = 35
      end
    CODE

    # should we passing in line number, column number, as well?
    output = refactor(input, convert('35'), 'fred')

    output.should == <<-CODE.undent
      def thing
        fred = 35
        june = fred
      end
    CODE
  end
end
