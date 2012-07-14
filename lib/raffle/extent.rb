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
      output = []
      lines.each_with_index do |line, index|
        start_col = (index == 0 ? start.column : 0)
	end_col = (index == lines.size - 1 ? finish.column : -1)
	output << line[start_col..end_col]
      end
      output.join($/)
    end
  end
end
