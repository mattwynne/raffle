require 'ripper_helper'
require 'raffle/refactorings/noop'

describe Raffle::Refactorings::Noop do
  it 'reformats all code to two space indentation' do
    input = <<-CODE
class Foo
  def bar
    [1, 2].each do |baz|
      puts baz
    end
  end
end
    CODE
    refactor(input).should == input
  end
end
