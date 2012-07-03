require 'ripper_helper'
require 'raffle/refactorings/noop'

describe Raffle::Refactorings::Noop do

  it 'flattens all your lovely indentation (sorry!)' do
    input = <<-CODE
class Foo
  def bar
    [1, 2].each do |baz|
      puts baz
    end
  end
end
    CODE
    output = 'class Foo
def bar
[1, 2].each do |baz|
puts baz
end
end
end'
    refactor(input).should == output
  end

  it 'respects your funny bracketing conventions' do
    input = <<-CODE
def foo bar
  (bar + (1))
end
    CODE
    output = 'def foo bar
(bar + (1))
end'
    refactor(input).should == output
  end
end
