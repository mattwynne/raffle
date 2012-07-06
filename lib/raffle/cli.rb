require 'raffle/refactorings'
module Raffle
  class CLI
    def initialize(file_system)
    end

    def run(refactoring, *args)
      eval("Raffle::Refactorings::#{refactoring}").new.call(*args)
    end
  end
end

