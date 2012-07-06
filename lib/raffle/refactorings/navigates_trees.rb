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
          if (current_sexp == scope_sexp)
            transform_respecting_scope_changes(child_sexp, scope_proc, &block)
          else
            transform_within_scope(child_sexp, scope_sexp, scope_proc, &block)
          end
        end
      end

      def transform_respecting_scope_changes(sexp, scope_proc, &block)
        return sexp unless sexp.respond_to?(:map)
        return sexp if scoping_delimiter?(sexp) && !scope_proc.call(sexp)
        (block.call(sexp) || sexp).map do |child|
          transform_respecting_scope_changes(child, scope_proc, &block)
        end
      end

      def transform(sexp, &block)
        transform_respecting_scope_changes(sexp, lambda { |x| true }, &block)
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

      def find_containing_scope(starting_sexp, inner_sexp)
        containing_scope = nil
        walk(starting_sexp) do |sexp|
          containing_scope = sexp if scoping_delimiter?(sexp)
          return containing_scope if sexp == inner_sexp
        end
        starting_sexp
      end

      def containing_scope_for_position(starting_sexp, position)
        find_containing_scope(starting_sexp, sexp_for_position(starting_sexp, position))
      end

      def sexp_for_position(starting_sexp, position)
        find_first(starting_sexp) do |sexp|
          positioned_on_or_after?(sexp, position)
        end
      end
    end
  end
end
