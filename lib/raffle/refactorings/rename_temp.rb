require_relative 'navigates_trees'
module Raffle
  module Refactorings
    class RenameTemp
      include NavigatesTrees

      def call(starting_sexp, original_name, new_name)
        transform(starting_sexp) do |sexp|
          next unless sexp[0] == :@ident && sexp[1] == original_name
          [:@ident, new_name, sexp[2]]
        end
      end

    end
  end
end
