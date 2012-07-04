module Raffle
  class Position
    attr :line, :column
    def initialize(line_and_column)
      @line, @column = line_and_column
    end
  end
end
