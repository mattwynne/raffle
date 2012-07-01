require_relative 'navigates_trees'
module Raffle
  module Refactorings
    class RenameTemp
      include NavigatesTrees

      def call(sexp, original_name, new_name)
        transform(sexp) do |node|
          next unless node[0] == :@ident && node[1] == original_name
          [:@ident, new_name, node[2]]
        end
      end

    end
  end
end
