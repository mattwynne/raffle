require_relative 'navigates_trees'
require_relative 'reads_sexps'
require_relative '../position'
module Raffle
  module Refactorings
    class RenameTemp
      include NavigatesTrees
      include ReadsSexps

      def call(starting_sexp, start_position, original_name, new_name)
        scope_sexp = containing_scope_for_position(starting_sexp, start_position)
        unless_scope_defines_variable_again = lambda do |new_scope|
          not defining_block_parameter?(new_scope, original_name)
        end
        transform_within_scope(starting_sexp, scope_sexp, unless_scope_defines_variable_again) do |sexp|
          next unless ident?(sexp, original_name)
          [:@ident, new_name, sexp[2]]
        end
      end

      private

      def sexp_for_position(starting_sexp, position)
        find_first(starting_sexp) do |sexp|
          positioned_on_or_after?(sexp, position)
        end
      end

      def defining_block_parameter?(starting_sexp, name)
        find_first(starting_sexp) do |sexp|
          block_parameter?(sexp, name)
        end
      end

    end
  end
end
