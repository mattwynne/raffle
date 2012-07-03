module Raffle
  module Refactorings
    class Noop
      def call(sexp)
        sexp
      end
    end
  end
end
