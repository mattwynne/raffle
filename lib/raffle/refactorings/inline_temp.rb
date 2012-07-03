require_relative 'reads_sexps'
require_relative 'navigates_trees'
module Raffle
  module Refactorings
    class InlineTemp
      include ReadsSexps
      include NavigatesTrees

      def call(sexp, temp_name)
        value = find_value_to_assign(sexp, temp_name)
        replace_temp_with_value(sexp, temp_name, value)
      end

      def find_value_to_assign(starting_sexp, temp_name)
        assign_sexp = find_last(starting_sexp) do |sexp|
          assignment_with_name?(sexp, temp_name)
        end
        assign_sexp[2]
      end

      def replace_temp_with_value(starting_sexp, temp_name, value)
        transform(starting_sexp) do |sexp|
          value if var_ref?(sexp, temp_name)
        end
      end
    end
  end
end

