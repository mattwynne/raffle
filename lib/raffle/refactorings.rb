Dir[File.dirname(__FILE__) + '/refactorings/*.rb'].each { |f| require f }

module Raffle
  module Refactorings

    RefactoringNotDefined = Class.new(StandardError)

    def self.find(name)
      eval("Raffle::Refactorings::#{name}").new
    rescue NameError
      raise RefactoringNotDefined, "The refactoring '#{name}' is not defined."
    end
  end
end
