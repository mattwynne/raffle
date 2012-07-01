require_relative 'refactoring'
module Raffle
  module Refactorings
    class RemoveUnusedTemp
      include Refactoring

      def call(sexpr, temp_name)
        return sexpr unless sexpr.respond_to?(:each)
        new = transform(sexpr, temp_name)
        new.map { |child| call(child, temp_name) }
      end

      def transform(node, temp_name)
        node.reject { |child| assignment_with_name?(child, temp_name) }
      end
    end
  end
end
