RSpec::Matchers.define :match_code do |expected|
  match do |actual|
    actual.should == expected
  end
end
