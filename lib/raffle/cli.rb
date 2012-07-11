require 'raffle/refactorings'
require 'ripper'
require 'sorcerer'
module Raffle
  class CLI < Struct.new(:file_system)

    def run(refactoring_name, *raw_args)
      args = Arguments.parse(raw_args)
      sexp = convert(file_system.read(args.file))
      refactoring = Refactorings.find(refactoring_name)
      result = refactoring.call(sexp, args.start_position, *args.rest)
      file_system.write(args.file, rubify(result))
    end

    def convert(source)
      Ripper::SexpBuilder.new(source).parse
    end

    def rubify(sexpr)
      Sorcerer.source(sexpr, multiline: true, indent: true)
    end

    class Arguments < Struct.new(:file, :start_position, :rest)
      def self.parse(raw_args)
        location = raw_args.shift
        file, raw_range = location.split(':')
        start_position = Position.new(raw_range.split(',').map(&:to_i))
        new(file, start_position, raw_args)
      end
    end
  end
end

