require_relative 'refactoring'
require_relative 'navigates_trees'
module Raffle
  module Refactorings
    class RemoveUnusedTemp
      include Refactoring
      include NavigatesTrees

      def call(sexpr, temp_name)
        transform(sexpr) do |node|
          node.reject { |child| assignment_with_name?(child, temp_name) }
        end
      end
    end
  end
end
