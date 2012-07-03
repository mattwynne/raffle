require 'ripper_helper'
require 'match_code_helper'
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
    refactor(input, 'fred', 'billy', [3,0]).should match_code <<-CODE
def foo
billy = 45
june = billy
end
def bar
fred = "captain"
end
CODE
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
      refactor(input, 'thing', 'bar', [3,0]).should match_code <<-CODE
def foo
bar = 34
[1].each do |number|
puts number + bar
end
puts bar
end
CODE
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
      refactor(input, 'thing', 'number', [3,0]).should match_code <<-CODE
def foo
number = 34
[1].each do |thing|
puts thing
end
puts number
end
CODE
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
      refactor(input, 'thing', 'number', [5,0]).should match_code <<-CODE
def foo
thing = 34
[1].each do |number|
puts number
end
puts thing
end
CODE
    end
  end

  context 'when the temp is a parameter'
end
