Given /^a file `(.*)` with:$/ do |path, string|
  write_file(path, string)
end

When /^I run `raffle (\w+) (.*)$/ do |refactoring, args|
  run_refactoring(refactoring, *args.split)
end

Then /^the file `(.*)` should contain:$/ do |path, string|
  assert_file_content(path, string)
end
