module Raffle
  module Refactorings
    class RemoveUnusedTemp
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

      def assignment_with_name?(sexpr, name)
        return false unless sexpr
        sexpr[0] == :assign &&
          sexpr[1][0] == :var_field &&
          sexpr[1][1][0] == :@ident &&
          sexpr[1][1][1] == name
      end
    end
  end
end
