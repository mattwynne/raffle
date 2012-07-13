require_relative 'navigates_trees'
require_relative 'reads_sexps'
require_relative '../position'
module Raffle
  module Refactorings
    class RenameTemp
      include NavigatesTrees
      include ReadsSexps

      def call(starting_sexp, extent, extent_sexp, new_name, recorder)
        original_name = name_of_ident_at_position(starting_sexp, extent.start)
        return recorder.invalid_starting_exent(extent) if original_name.nil?

        scope_sexp = containing_scope_for_position(starting_sexp, extent.start)
        unless_scope_defines_variable_again = lambda do |new_scope|
          not defining_block_parameter?(new_scope, original_name)
        end
        transform_within_scope(starting_sexp, scope_sexp, unless_scope_defines_variable_again) do |sexp|
          next unless ident?(sexp, original_name)
          [:@ident, new_name, sexp[2]]
        end
      end

      private

      def defining_block_parameter?(starting_sexp, name)
        find_first(starting_sexp) do |sexp|
          block_parameter?(sexp, name)
        end
      end

    end
  end
end
