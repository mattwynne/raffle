require 'string_helper'
require 'raffle/extent'

module Raffle
  describe Extent do
    it "parses a string representation" do
      extent = Extent.parse '1,2-3,4'
      extent.start.line.should == 1
      extent.start.column.should == 2
      extent.finish.line.should == 3
      extent.finish.column.should == 4
    end
  
    context "slicing a piece of source code" do
      it "returns the range specified" do
        source = <<-SOURCE.undent
          01234
          abcde
          ABCDE
        SOURCE

        expected = <<-EXPECTED.undent
          234
          abcde
          ABCD
        EXPECTED
        output = Extent.parse('1,2-3,3').slice(source)
        output.should == expected.chomp
      end

      it "works for a single line" do
        Extent.parse('1,1-1,1').slice('abc').should == 'b'
      end
    end
  end
end
