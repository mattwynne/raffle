require_relative 'reads_sexps'
require_relative 'navigates_trees'
module Raffle
  module Refactorings
    class IntroduceTemp
      include ReadsSexps
      include NavigatesTrees

      def call(sexp, extract_sexp, new_name)
        sexp
      end
    end
  end
end
