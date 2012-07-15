module Raffle
  module Refactorings
    class Noop
      def call(sexp, extent, extent_sexp, recorder)
        sexp
      end
    end
  end
end
