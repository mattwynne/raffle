module Raffle
  module Refactorings
    module ReadsSexps
      def assignment_with_name?(sexp, name)
        return false unless sexp
        (
          sexp[0] == :assign &&
          sexp[1][0] == :var_field &&
          ident?(sexp[1][1], name)
        )
      end

      def var_ref?(sexp, name)
        (
          sexp[0] == :var_ref &&
          ident?(sexp[1], name)
        )
      end

      def scoping_delimiter?(sexp)
        (
          sexp[0] == :def ||
          sexp[0] == :do_block
        )
      end

      def block_parameter?(sexp, name)
        (
          sexp[0] == :block_var &&
          sexp[1][0] == :params &&
          ident?(sexp[1][1][0], name)
        )
      end

      def ident?(sexp, name)
        (
          sexp[0] == :@ident &&
          sexp[1] == name
        )
      end

      def positioned_before?(sexp, position)
        return false unless has_positional_information?(sexp)
        Position.new(sexp[2]) < position
      end

      def positioned_on_or_after?(sexp, position)
        return false unless has_positional_information?(sexp)
        Position.new(sexp[2]) >= position
      end

      def has_positional_information?(sexp)
        (
          sexp[2].kind_of?(Array) &&
          sexp[2].size == 2 &&
          sexp[2][0].kind_of?(Fixnum) &&
          sexp[2][1].kind_of?(Fixnum)
        )
      end
    end
  end
end
