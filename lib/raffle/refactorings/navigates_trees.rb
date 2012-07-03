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

      def transform_within_scope(current_sexp, scope_sexp, &block)
        return current_sexp unless current_sexp.respond_to?(:map)
        current_sexp.map do |child_sexp|
          if (child_sexp == scope_sexp)
            transform(child_sexp, &block)
          else
            transform_within_scope(child_sexp, scope_sexp, &block)
          end
        end
      end

      def transform(sexp, &block)
        return sexp unless sexp.respond_to?(:map)
        (block.call(sexp) || sexp).map do |child|
          transform(child, &block)
        end
      end

      def find_last(sexp, &block)
        result = nil
        walk(sexp) do |child_sexp|
          result = child_sexp if block.call(child_sexp)
        end
        result
      end
    end
  end
end
