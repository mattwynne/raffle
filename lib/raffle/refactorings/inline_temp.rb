require_relative 'refactoring'
require_relative 'navigates_trees'
module Raffle
  module Refactorings
    class InlineTemp
      include Refactoring
      include NavigatesTrees

      def call(sexpr, temp_name)
        value = find_value_to_assign(sexpr, temp_name)
        replace_temp_with_value(sexpr, temp_name, value)
      end

      def find_value_to_assign(sexpr, temp_name)
        walk(sexpr) do |node|
          if assignment_with_name?(node, temp_name)
            @value_returned = node[2]
          end
        end
        @value_returned
      end

      def replace_temp_with_value(sexpr, temp_name, value)
        transform(sexpr) do |node|
          if (node[0] == :var_ref && node[1][0] == :@ident && node[1][1] == temp_name)
            value
          end
        end
      end
    end
  end
end

