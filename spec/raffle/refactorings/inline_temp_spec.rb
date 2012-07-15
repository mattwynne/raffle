require 'ripper_helper'
require_relative '../../../lib/raffle/refactorings/inline_temp'

describe Raffle::Refactorings::InlineTemp do

  context 'when the temp can be safely inlined' do

    it 'replaces all uses of the temp' do
      input = <<'CODE'
def thing
  fred = 35
  june = fred
  "I was #{fred} years old"
end
CODE
      output = refactor(input, '2,2-2,5', "fred", Raffle::Recorder.new)
      output.should == <<'CODE'
def thing
  fred = 35
  june = 35
  "I was #{35} years old"
end
CODE
    end

    context 'when the temp uses an overloaded name' do
      # e.g.
      # def foo
      #   name = "fred"
      #   @names.each {|name| p name }
      #   "#{name} ace"
      # end
      pending 'how do we specify which one to inline?'
    end

    context 'when the temp occurs in several methods' do
      # e.g.
      # def foo
      #   name = "fred"
      #   "#{name} ace"
      # end
      #
      # def bar
      #   name = "fred"
      #   "#{name} ace"
      # end
      pending 'how do we specify which one to inline?'
    end

  end

  context 'when the temp cannot be safely inlined' do

    context 'when the temp is mutated' do
      # e.g.
      # def foo
      #   name = "fred"
      #   name << " is "
      #   "#{name} ace"
      # end
      it 'throws an error'
    end

    context 'when the temp is assigned twice' do
      # e.g.
      # def foo
      #   name = "fred"
      #   @lucy = name
      #   name = 'bob'
      #   "#{name} ace"
      # end
      it 'throws an error'
    end

  end

end

