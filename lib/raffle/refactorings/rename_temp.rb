require_relative 'navigates_trees'
module Raffle
  module Refactorings
    class RenameTemp
      include NavigatesTrees

      def call(sexpr, original_name, new_name)
        transform(sexpr) do |node|
          if node[0] == :@ident && node[1] == original_name
            [:@ident, new_name, node[2]]
          end
        end
      end

    end
  end
end
