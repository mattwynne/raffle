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

      def transform_within_scope(current_sexp, scope_sexp, scope_proc, &block)
        return current_sexp unless current_sexp.respond_to?(:map)
        current_sexp.map do |child_sexp|
          if (child_sexp == scope_sexp)
            transform_no_scope_boundary_change(child_sexp, scope_proc, &block)
          else
            transform_within_scope(child_sexp, scope_sexp, scope_proc, &block)
          end
        end
      end

      def transform_no_scope_boundary_change(sexp, scope_proc, &block)
        return sexp unless sexp.respond_to?(:map)
        return sexp if scoping_delimiter?(sexp) && !scope_proc.call(sexp)
        (block.call(sexp) || sexp).map do |child|
          transform_no_scope_boundary_change(child, scope_proc, &block)
        end
      end

      def transform(sexp, &block)
        transform_no_scope_boundary_change(sexp, lambda { |x| true }, &block)
      end

      def find_last(sexp, &block)
        result = nil
        walk(sexp) do |child_sexp|
          result = child_sexp if block.call(child_sexp)
        end
        result
      end

      def find_first(sexp, &block)
        result = nil
        walk(sexp) do |child_sexp|
          result ||= child_sexp if block.call(child_sexp)
        end
        result
      end
    end
  end
end
