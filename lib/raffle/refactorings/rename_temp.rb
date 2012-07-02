require_relative 'navigates_trees'
module Raffle
  module Refactorings
    class RenameTemp
      include NavigatesTrees
      include ReadsSexps

      def call(starting_sexp, original_name, new_name)
        transform(starting_sexp) do |sexp|
          next unless ident?(sexp, original_name)
          [:@ident, new_name, sexp[2]]
        end
      end

    end
  end
end
