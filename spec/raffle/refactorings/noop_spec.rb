require 'ripper_helper'
require 'string_helper'
require 'raffle/refactorings/noop'

describe Raffle::Refactorings::Noop do

  it 'respects standard 2-space indentation' do
    input = <<-CODE.undent
      class Foo
        def bar
          [1, 2].each do |baz|
            puts baz
          end
        end
      end
    CODE
    output = <<-CODE.undent
      class Foo
        def bar
          [1, 2].each do |baz|
            puts baz
          end
        end
      end
    CODE
    refactor(input, '1,1-1,1', Raffle::Recorder.new).should == output
  end

  it 'respects your funny bracketing conventions' do
    input = <<-CODE.undent
      def foo bar
        (bar + (1))
      end
    CODE
    output = <<-CODE.undent
      def foo bar
        (bar + (1))
      end
    CODE
    refactor(input, '1,1-1,1', Raffle::Recorder.new).should == output
  end
end
