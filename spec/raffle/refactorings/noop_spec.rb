require 'ripper_helper'
require 'raffle/refactorings/noop'

describe Raffle::Refactorings::Noop do

  it 'respects standard 2-space indentation' do
    input = <<CODE
class Foo
  def bar
    [1, 2].each do |baz|
      puts baz
    end
  end
end
CODE
    output = <<CODE
class Foo
  def bar
    [1, 2].each do |baz|
      puts baz
    end
  end
end
CODE
    refactor(input).should == output
  end

  it 'respects your funny bracketing conventions' do
    input = <<CODE
def foo bar
  (bar + (1))
end
CODE
    output = <<CODE
def foo bar
  (bar + (1))
end
CODE
    refactor(input).should == output
  end
end
