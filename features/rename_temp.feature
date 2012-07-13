Feature: Rename temp

  This refactoring replaces all uses of a given temporary
  variable with a new name.

  Background:
    Given a file `lib/foo.rb` with:
      """
      def name
        fred = "fred"
        "My name is " + fred
      end

      """

  Scenario: Rename temp by pointing to it
    When I run `raffle RenameTemp lib/foo.rb:2,2-2,5 name`
    Then the file `lib/foo.rb` should contain:
      """
      def name
        name = "fred"
        "My name is " + name
      end

      """

