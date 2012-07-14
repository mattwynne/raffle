require 'raffle/refactorings'

module Raffle
  describe Refactorings do
    describe ".find" do
      it "finds refactorings that exist" do
        Refactorings.find('Noop').should be_instance_of(Raffle::Refactorings::Noop)
      end

      it "raises an error if the refactoring does not exist" do
        expect { Refactorings.find('DestroyAll') }.to raise_error(Refactorings::RefactoringNotDefined)
      end
    end
  end
end
