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

  context 'with a block scoped temp' do
    it 'renames the temp inside the block' do
      input = %{
        def foo
          thing = 34
          [1].each do |number|
            puts number + thing
          end
          puts thing
        end
      }
      output = refactor(input, 'thing', 'bar', [3,0])
      output.should == "def foo\nbar = 34\n[1].each do |number|\nputs number + bar\nend\nputs bar\nend"
      #def foo
      #  bar = 34
      #  [1].each do |number|
      #    puts number + bar
      #  end
      #  puts bar
      #end
    end

    it 'ignores block temps when the method temp is selected' do
      input = %{
        def foo
          thing = 34
          [1].each do |thing|
            puts thing
          end
          puts thing
        end
      }
      output = refactor(input, 'thing', 'number', [3,0])
      output.should == %{def foo\nnumber = 34\n[1].each do |thing|\nputs thing\nend\nputs number\nend}
      #def foo
      #  number = 34
      #  [1].each do |thing|
      #    puts thing
      #  end
      #  puts number
      #end
      pending
    end

    it 'ignores method temps when the block temp is selected' do
      input = %{
        def foo
          thing = 34
          [1].each do |thing|
            puts thing
          end
          puts thing
        end
      }
      output = refactor(input, 'thing', 'number', [5,0])
      output.should == %{def foo\nthing = 34\n[1].each do |number|\nputs number\nend\nputs thing\nend}
      #def foo
      #  number = 34
      #  [1].each do |thing|
      #    puts thing
      #  end
      #  puts number
      #end
      pending
    end
  end

  context 'when the temp is a parameter'
end
