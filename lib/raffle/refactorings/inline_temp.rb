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
        if sexpr.respond_to?(:each)
          if assignment_with_name?(sexpr, temp_name)
            @value_returned = sexpr[2]
          end
          sexpr.each do |s|
            find_value_to_assign(s, temp_name)
          end
        end
        @value_returned
      end

      def replace_temp_with_value(sexpr, temp_name, value)
        if sexpr.respond_to?(:each)
          if (sexpr[0] == :var_ref && sexpr[1][0] == :@ident && sexpr[1][1] == temp_name)
            value
          else
            sexpr.map do |s|
              replace_temp_with_value(s, temp_name, value)
            end
          end
        else
          sexpr
        end
      end
    end
  end
end

