module Raffle
  module Refactorings
    module Refactoring
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
