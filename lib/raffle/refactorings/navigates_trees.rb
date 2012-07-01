module Raffle
  module Refactorings
    module NavigatesTrees
      def walk(node, &block)
        return unless node.respond_to?(:each)
        block.call(node)
        node.each do |child|
          walk(child, &block)
        end
      end

      def transform(node, &block)
        return node unless node.respond_to?(:map)
        block.call(node) || node.map do |child|
          transform(child, &block)
        end
      end
    end
  end
end
