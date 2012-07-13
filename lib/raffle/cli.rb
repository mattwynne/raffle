require 'raffle/refactorings'
require 'ripper'
require 'raffle/extent'
require 'sorcerer'
module Raffle
  class CLI < Struct.new(:file_system)

    def run(refactoring_name, *raw_args)
      args = Arguments.parse(raw_args)
      source = file_system.read(args.file)
      source_sexp = convert(source)
      extent_sexp = convert(args.extent.slice(source))
      # ASSERT that extent_sexp is inside source_sexp
      refactoring = Refactorings.find(refactoring_name)
      result = refactoring.call(source_sexp, args.extent, extent_sexp, *args.rest)
      file_system.write(args.file, rubify(result))
    end

    def convert(source)
      Ripper::SexpBuilder.new(source).parse
    end

    def rubify(sexpr)
      Sorcerer.source(sexpr, multiline: true, indent: true)
    end

    class Arguments < Struct.new(:file, :extent, :rest)
      def self.parse(raw_args)
        location = raw_args.shift
        file, raw_extent = location.split(':')
        new(file, Extent.parse(raw_extent), raw_args)
      end
    end
  end
end

