require_relative 'navigates_trees'
require_relative 'reads_sexps'
module Raffle
  module Refactorings
    class RenameTemp
      include NavigatesTrees
      include ReadsSexps

      def sexp_for_position(starting_sexp, line, column)
        find_first(starting_sexp) do |sexp|
          positioned_on_or_after?(sexp, line, column)
        end
      end

      def find_containing_scope_in(starting_sexp, inner_sexp)
        containing_scope = nil
        walk(starting_sexp) do |sexp|
          containing_scope = sexp if scoping_delimiter?(sexp)
          return containing_scope if sexp == inner_sexp
        end
        starting_sexp
      end

      def call(starting_sexp, original_name, new_name, line_and_column)
        line, column = line_and_column
        position_sexp = sexp_for_position(starting_sexp, line, column)
        scope_sexp = find_containing_scope_in(starting_sexp, position_sexp)
        run_when_scope_boundary_change = lambda do |new_scope|
          return true if new_scope == scope_sexp
        end
        transform_within_scope(starting_sexp, scope_sexp, run_when_scope_boundary_change) do |sexp|
          next unless ident?(sexp, original_name)
          [:@ident, new_name, sexp[2]]
        end
      end

    end
  end
end
