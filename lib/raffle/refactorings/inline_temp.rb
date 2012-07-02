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
        walk(starting_sexp) do |sexp|
          next unless assignment_with_name?(sexp, temp_name)
          @value_returned = sexp[2]
        end
        @value_returned
      end

      def replace_temp_with_value(starting_sexp, temp_name, value)
        transform(starting_sexp) do |sexp|
          if (sexp[0] == :var_ref && sexp[1][0] == :@ident && sexp[1][1] == temp_name)
            value
          end
        end
      end
    end
  end
end

