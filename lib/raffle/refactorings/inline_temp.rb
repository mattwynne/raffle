require_relative 'refactoring'
module Raffle
  module Refactorings
    class InlineTemp
      include Refactoring

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

      def walk(node, &block)
        return unless node.respond_to?(:each)
        block.call(node)
        node.each do |child|
          walk(child, &block)
        end
      end

      def transform(node, &block)
        return node unless node.respond_to?(:map)
        block.call(node) || node.map do |child|
          transform(child, &block)
        end
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

