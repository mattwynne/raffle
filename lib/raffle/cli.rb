require 'raffle/refactorings'
require 'ripper'
require 'raffle/extent'
require 'raffle/recorder'
require 'raffle/file_system'
module Raffle

  class CLI < Struct.new(:file_system)
    def self.invoke
      file_system = Raffle::FileSystem.new
      result = Raffle::CLI.new(file_system).run(*ARGV)
      result.report
      result.exit_status
    end

    def run(refactoring_name, *raw_args)
      args = Arguments.parse(raw_args)
      source = file_system.read(args.file)
      source_sexp = convert(source)
      extent_sexp = convert(args.extent.slice(source))
      refactoring = Refactorings.find(refactoring_name)
      recorder = Raffle::Recorder.new
      recorder.output_sexp(refactoring.call(source_sexp, args.extent, extent_sexp, *args.rest, recorder))
      recorder.result
    end

    def convert(source)
      Ripper::SexpBuilder.new(source).parse
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

