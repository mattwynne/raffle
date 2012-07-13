require 'sorcerer'

module Raffle
  class Recorder
    def output_sexp(sexp)
      @output_sexp = sexp
      self
    end

    def result
      SuccessfulResult.new(@output_sexp)
    end
  end

  class SuccessfulResult < Struct.new(:output_sexp)
    def resulting_code
      rubify(output_sexp)
    end

    def report
      $stdout.puts(result)
    end

    def rubify(sexpr)
      Sorcerer.source(sexpr, multiline: true, indent: true)
    end

    def exit_status
      0
    end
  end
end
