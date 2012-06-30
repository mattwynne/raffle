module Raffle
  module Refactorings
    class RenameTemp
      def call(sexpr, original_name, new_name)
        rename_temp(sexpr, original_name, new_name)
      end

      private

      def rename_temp(sexpr, original_name, new_name)
        if sexpr.respond_to?(:each)
          new = replace_ident(sexpr, original_name, new_name)
          new.map { |child| rename_temp(child, original_name, new_name) }
        else
          sexpr
        end
      end

      def replace_ident(node, original_name, new_name)
        return node unless node[0] == :@ident && node[1] == original_name
        [:@ident, new_name, node[2]]
      end
    end
  end
end
