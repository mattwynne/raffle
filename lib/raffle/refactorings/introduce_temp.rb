require_relative 'reads_sexps'
require_relative 'navigates_trees'
require_relative '../position'
module Raffle
  module Refactorings
    class IntroduceTemp
      include ReadsSexps
      include NavigatesTrees

      def find_statements_block_for(starting_sexp, inner_sexp)
        containing_scope = nil
        walk(starting_sexp) do |sexp|
          containing_scope = sexp if sexp[0] == :stmts_add
          return containing_scope if sexp == inner_sexp
        end
        starting_sexp
      end

#[:program,
 #[:stmts_add,
  #[:stmts_new],
  #[:def,
   #[:@ident, "thing", [1, 4]],
   #[:params, nil, nil, nil, nil, nil],
   #[:bodystmt,
    #[:stmts_add,
     #[:stmts_new],
     #[:assign,
      #[:var_field, [:@ident, "june", [2, 2]]],
      #[:@int, "35", [2, 9]]]],
    #nil,
    #nil,
    #nil]]]]

#[:program,
 #[:stmts_add,
  #[:stmts_new],
  #[:def,
   #[:@ident, "thing", [1, 4]],
   #[:params, nil, nil, nil, nil, nil],
   #[:bodystmt,
    #[:stmts_add,
     #[:stmts_add,
      #[:stmts_new],
      #[:assign,
       #[:var_field, [:@ident, "fred", [2, 2]]],
       #[:@int, "35", [2, 9]]]],
     #[:assign,
      #[:var_field, [:@ident, "june", [3, 2]]],
      #[:var_ref, [:@ident, "fred", [3, 9]]]]],
    #nil,
    #nil,
    #nil]]]]


      def call(starting_sexp, extraction_sexp, temp_name, line_and_column)
        sexp_for_position = sexp_for_position(starting_sexp, Position.new(line_and_column))
        statments_sexp = find_statements_block_for(starting_sexp, sexp_for_position)


        out_sexp = transform(starting_sexp) do |sexp|
          if sexp == sexp_for_position
            var_ref(temp_name)
          elsif sexp == statments_sexp
            statments_sexp.insert(2, assign(temp_name, extraction_sexp))
          end
        end
        pp out_sexp
        out_sexp
      end

      def assign(name, value_sexp, line_and_column = [0,0])
        [:assign,
          [:var_field, [:@ident, name, line_and_column]], # TODO: Do we need to understand position
          value_sexp]
      end

      def var_ref(name, line_and_column = [0,0])
        [:var_ref, [:@ident, name, line_and_column]]
      end

    end
  end
end
