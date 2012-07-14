require 'sorcerer'

module Raffle
  class Recorder
    def initialize
      @errors = []
    end

    def output_sexp(sexp)
      @output_sexp = sexp
      self
    end

    def invalid_starting_exent(extent)
      @errors << "The starting extent was invalid."
    end

    def result
      if @errors.empty?
        SuccessfulResult.new(@output_sexp)
      else
        FailedResult.new(@errors)
      end
    end
  end

  class SuccessfulResult < Struct.new(:output_sexp)
    def to_s
      rubify(output_sexp)
    end

    def report
      $stdout.puts(self)
    end

    def rubify(sexpr)
      Sorcerer.source(sexpr, multiline: true, indent: true)
    end

    def exit_status
      0
    end
  end

  class FailedResult < Struct.new(:errors)
    def to_s
      errors.join("\n") + "\n"
    end

    def report
      $stderr.puts(self)
    end

    def exit_status
      1
    end
  end
end
