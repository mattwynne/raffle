Feature: Remove unused temp

  This refactoring will remove a temporary (local) variable if
  it is unused elsewhere within its scope.

  Background:
    Given a file `lib/foo/bar.rb` with:
      """
      module Foo
        class Bar
          def baz
            fred = 'whatever'
            5 * 25
          end
          def other
            fred = 'unused again'
            1
          end
        end
      end
      """

  Scenario: Refer to temp to remove by name
    Unless you specify a scope, the temp will be removed *everywhere*
    within the file.

    When I run `raffle RemoveUnusedTemp lib/foo/bar.rb fred`
    Then the file `lib/foo/bar.rb` should contain:
      """
      module Foo
        class Bar
          def baz
            5 * 25
          end
          def other
            1
          end
        end
      end

      """

