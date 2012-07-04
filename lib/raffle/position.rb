module Raffle
  class Position
    attr :line, :column
    def initialize(line_and_column)
      @line, @column = line_and_column
    end

    def <(other)
      line < other.line ||
      (
        line == other.line &&
        column < other.column
      )
    end

    def >=(other)
      !self.<(other)
    end
  end
end
