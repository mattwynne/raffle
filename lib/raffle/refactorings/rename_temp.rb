module Raffle
  module Refactorings
    class RenameTemp
      def call(sexpr, original_name, new_name)
        return sexpr unless sexpr.respond_to?(:each)
        new = transform(sexpr, original_name, new_name)
        new.map { |child| call(child, original_name, new_name) }
      end

      def transform(node, original_name, new_name)
        return node unless node[0] == :@ident && node[1] == original_name
        [:@ident, new_name, node[2]]
      end
    end
  end
end
