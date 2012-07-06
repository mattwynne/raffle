Feature: Remove unused temp

  Scenario: Refer to temp to remove by position with the file
    Given a file `lib/foo/bar.rb` with:
      """
      module Foo
        class Bar
          def baz
            fred = 'whatever'
            5 * 25
          end
        end
      end
      """
    When I run `raffle RemoveUnusedTemp lib/foo/bar.rb:4,7`
    Then the file `lib/foo/bar.rb` should contain:
      """
      module Foo
        class Bar
          def baz
            5 * 25
          end
        end
      end
      """

