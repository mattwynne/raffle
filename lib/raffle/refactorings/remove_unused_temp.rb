require_relative 'reads_sexps'
require_relative 'navigates_trees'
module Raffle
  module Refactorings
    class RemoveUnusedTemp
      include ReadsSexps
      include NavigatesTrees

      def call(starting_sexp, extent, extent_sexp, recorder)
        temp_name = name_of_ident_at_position(starting_sexp, extent.start)
        walk(starting_sexp) do |sexp|
          if scoping_delimiter?(sexp)
            return starting_sexp if more_than_one_use_of?(sexp, temp_name)
          end
        end
        transform(starting_sexp) do |sexp|
          sexp.reject { |child| assignment_with_name?(child, temp_name) }
        end
      end

      def more_than_one_use_of?(starting_sexp, temp_name)
        starting_sexp.flatten.count { |element| element == temp_name } > 1
      end
    end
  end
end
