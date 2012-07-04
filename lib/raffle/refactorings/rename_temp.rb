require_relative 'navigates_trees'
require_relative 'reads_sexps'
require_relative '../position'
module Raffle
  module Refactorings
    class RenameTemp
      include NavigatesTrees
      include ReadsSexps

      def sexp_for_position(starting_sexp, position)
        find_first(starting_sexp) do |sexp|
          positioned_on_or_after?(sexp, position)
        end
      end

      def has_block_parameter_of?(starting_sexp, name)
        find_first(starting_sexp) do |sexp|
          block_parameter?(sexp, name)
        end
      end

      def call(starting_sexp, original_name, new_name, line_and_column)
        position_sexp = sexp_for_position(starting_sexp, Position.new(line_and_column))
        scope_sexp = find_containing_scope(starting_sexp, position_sexp)
        unless_scope_defines_variable_again = lambda do |new_scope|
          return true if new_scope == scope_sexp
          return false if has_block_parameter_of?(new_scope, original_name)
          true
        end
        transform_within_scope(starting_sexp, scope_sexp, unless_scope_defines_variable_again) do |sexp|
          next unless ident?(sexp, original_name)
          [:@ident, new_name, sexp[2]]
        end
      end

    end
  end
end
