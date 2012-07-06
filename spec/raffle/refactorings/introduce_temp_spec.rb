require 'ripper_helper'
require_relative '../../../lib/raffle/refactorings/introduce_temp'

describe Raffle::Refactorings::IntroduceTemp do
  it 'extracts the selected code as a temp' do
    input = <<CODE
def thing
  june = 35
end
CODE

    # should we passing in line number, column number, as well?
    output = refactor(input, convert('35'), 'fred', [2,9])

    output.should == <<CODE
def thing
  fred = 35
  june = fred
end
CODE
  end
end
