module Raffle
  module Refactorings
    class RenameTemp
      def call(sexpr, original_name, new_name)
        transform(sexpr) do |node|
          if node[0] == :@ident && node[1] == original_name
            [:@ident, new_name, node[2]]
          end
        end
      end

      def transform(node, &block)
        return node unless node.respond_to?(:map)
        block.call(node) || node.map do |child|
          transform(child, &block)
        end
      end
    end
  end
end
