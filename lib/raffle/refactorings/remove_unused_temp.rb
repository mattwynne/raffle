require_relative 'reads_sexps'
require_relative 'navigates_trees'
module Raffle
  module Refactorings
    class RemoveUnusedTemp
      include ReadsSexps
      include NavigatesTrees

      def call(sexp, temp_name)
        transform(sexp) do |node|
          node.reject { |child| assignment_with_name?(child, temp_name) }
        end
      end
    end
  end
end
