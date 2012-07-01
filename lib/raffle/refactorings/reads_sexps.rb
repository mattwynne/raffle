module Raffle
  module Refactorings
    module ReadsSexps
      def assignment_with_name?(sexp, name)
        return false unless sexp
        sexp[0] == :assign &&
          sexp[1][0] == :var_field &&
          sexp[1][1][0] == :@ident &&
          sexp[1][1][1] == name
      end
    end
  end
end
