module Raffle
  module Refactorings
    module ReadsSexps
      def assignment_with_name?(sexp, name)
        return false unless sexp
        (
          sexp[0] == :assign &&
          sexp[1][0] == :var_field &&
          sexp[1][1][0] == :@ident &&
          sexp[1][1][1] == name
        )
      end

      def var_ref?(sexp, name)
        (
          sexp[0] == :var_ref &&
          sexp[1][0] == :@ident &&
          sexp[1][1] == name
        )
      end

      def ident?(sexp, name)
        (
          sexp[0] == :@ident && 
          sexp[1] == name
        )
      end
    end
  end
end
