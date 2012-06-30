require_relative 'refactoring'
module Raffle
  module Refactorings
    class RemoveUnusedTemp
      include Refactoring
      def call(sexpr, temp_name)
        remove_node(sexpr, temp_name)
      end

      private

      def remove_node(sexpr, temp_name)
        if sexpr.respond_to?(:each)
          filtered_expressions = sexpr.reject { |child| assignment_with_name?(child, temp_name) }
          filtered_expressions.map { |s| remove_node(s, temp_name) }
        else
          sexpr
        end
      end
    end
  end
end
