module Raffle
  module Refactorings
    module NavigatesTrees
      def walk(sexp, &block)
        return unless sexp.respond_to?(:each)
        block.call(sexp)
        sexp.each do |child|
          walk(child, &block)
        end
      end

      def transform(sexp, &block)
        return sexp unless sexp.respond_to?(:map)
        (block.call(sexp) || sexp).map do |child|
          transform(child, &block)
        end
      end
    end
  end
end
