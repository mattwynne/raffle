require 'ripper_helper'
require 'match_code_helper'
require_relative '../../../lib/raffle/refactorings/rename_temp'
require 'raffle/extent'

module Raffle
describe Refactorings::RenameTemp do
  it 'changes all occurrences of the temp name, but only within the given scope' do
    input = <<CODE
def foo
  fred = 45
  june = fred
end

def bar
  fred = "captain"
end
CODE
    refactor(input, '2,2-2,6', 'billy', Raffle::Recorder.new).should match_code <<CODE
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
      input = <<CODE
def foo
  thing = 34
  [1].each do |number|
    puts number + thing
  end
  puts thing
end
CODE
      refactor(input, '2,2-2,6', 'bar', Raffle::Recorder.new).should match_code <<CODE
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
      input = <<CODE
def foo
  thing = 34
  [1].each do |thing|
    puts thing
  end
  puts thing
end
CODE
      refactor(input, '2,2-2,6', 'number', Raffle::Recorder.new).should match_code <<CODE
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
      input = <<CODE
def foo
  thing = 34
  [1].each do |thing|
    puts thing
  end
  puts thing
end
CODE
      result = refactor(input, '4,9-4,13', 'number', Raffle::Recorder.new)
      expected = <<CODE
def foo
  thing = 34
  [1].each do |number|
    puts number
  end
  puts thing
end
CODE
      result.should match_code expected
    end
  end

  context 'with a begin/end scoped temp' do
    it 'always changes all the referenced values wherever the position is' do
      input = <<CODE
def foo
  thing = 34
  begin
    thing = 35
  end
  puts thing
end
CODE
      expected = <<CODE
def foo
  number = 34
  begin
    number = 35
  end
  puts number
end
CODE
    refactor(input, '2,2-2,6', 'number', Raffle::Recorder.new).should match_code(expected)
    refactor(input, '4,4-4,9', 'number', Raffle::Recorder.new).should match_code(expected)
    end
  end

  context 'when the temp is a parameter' do
    pending 'what should we do here? change the parameter name too, or just change the local variable?'
  end
end
end
