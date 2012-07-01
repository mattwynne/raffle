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

      def find_value_to_assign(sexp, temp_name)
        walk(sexp) do |node|
          next unless assignment_with_name?(node, temp_name)
          @value_returned = node[2]
        end
        @value_returned
      end

      def replace_temp_with_value(sexp, temp_name, value)
        transform(sexp) do |node|
          if (node[0] == :var_ref && node[1][0] == :@ident && node[1][1] == temp_name)
            value
          end
        end
      end
    end
  end
end

