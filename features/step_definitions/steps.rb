Given /^a file `(.*)` with:$/ do |path, string|
  write_file(path, string)
end

When /^I run `raffle (\w+) (.*)`$/ do |refactoring, args|
  run_refactoring(refactoring, *args.split)
end

Then /^the file `(.*)` should contain:$/ do |path, string|
  assert_file_content(path, string)
end

Then /^the output should be:$/ do |string|
  last_output.should == string
end

Then /^the tool should return an error code$/ do
  last_exit_status.should_not eq(0)
end

Then /^the tool should run successfully$/ do
  last_exit_status.should eq(0)
end
