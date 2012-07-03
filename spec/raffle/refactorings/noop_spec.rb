require 'ripper_helper'
require 'raffle/refactorings/noop'

describe Raffle::Refactorings::Noop do

  def round_trip(input)
    # sourcerer skips the last newline, but it makes our tests more readable
    refactor(input).should == input.split("\n").join("\n")
  end

  it 'reformats all code to two space indentation' do
    round_trip <<-CODE
class Foo
  def bar
    [1, 2].each do |baz|
      puts baz
    end
  end
end
    CODE
  end

  it 'respects your funny bracketing conventions' do
    round_trip <<-CODE
def foo bar
(bar + (1))
end
    CODE
  end
end
