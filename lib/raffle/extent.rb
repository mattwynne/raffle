require 'raffle/position'
module Raffle
  class Extent < Struct.new(:start, :finish)
    def self.parse(raw)
      raw_start_position, raw_finish_position = raw.split('-')
      start_position = Position.new(raw_start_position.split(',').map(&:to_i))
      finish_position = Position.new(raw_finish_position.split(',').map(&:to_i))
      new(start_position, finish_position)
    end

    def slice(source)
      lines = source.split($/)[(start.line - 1)..(finish.line - 1)]
      lines[0] = lines.first.slice(start.column..-1)
      lines[-1] = lines.last.slice(0..finish.column)
      lines.join($/)
    end
  end
end
