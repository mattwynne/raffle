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
        source = <<SOURCE
01234
abcde
ABCDE
SOURCE
        expected = <<EXPECTED
234
abcde
ABCD
EXPECTED
        output = Extent.parse('1,2-3,3').slice(source)
        output.should == expected.chomp
      end
    end
  end
end
