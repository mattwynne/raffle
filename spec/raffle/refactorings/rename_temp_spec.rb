require 'ripper'
require 'sorcerer'
require 'awesome_print'
require_relative '../../../lib/raffle/refactorings/rename_temp'

describe Raffle::Refactorings::RenameTemp do

  it 'changes all occurrences of the temp name' do
    input = %{
      def foo
        fred = 45
        june = fred
      end
    }
    output = refactor(input, 'fred', 'billy')
    output.should == "def foo\nbilly = 45\njune = billy\nend"
  end

  context 'when the temp is a parameter'

  def refactor(input, *args)
    sexp = convert(input)
    result = subject.call(sexp, *args)
    rubify(result)
  end

  def convert(source)
    Ripper::SexpBuilder.new(source).parse
  end

  def rubify(sexpr)
    Sorcerer.source(sexpr, multiline: true)
  end
end
