require 'raffle/refactorings'
require 'ripper'
require 'sorcerer'
module Raffle
  class CLI < Struct.new(:file_system)

    def run(refactoring_name, *args)
      refactoring = Refactorings.find(refactoring_name)
      file = args.shift
      sexp = convert(file_system.read(file))
      result = refactoring.call(sexp, *args)
      file_system.write(file, rubify(result))
    end

    def convert(source)
      Ripper::SexpBuilder.new(source).parse
    end

    def rubify(sexpr)
      Sorcerer.source(sexpr, multiline: true, indent: true)
    end
  end
end

