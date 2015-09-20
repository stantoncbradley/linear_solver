require 'spec_helper'
describe LinearSolver do

  context 'given invalid params' do

    it 'raises calculation unsolvable error if upper bounds limit is reached before input > goal' do
      expect {
        goal = 1
        LinearSolver::solve_equal(goal, 1) do |input|
          input = 1 if input == 0
          0 / input
        end
      }.to raise_exception(CalculationUnsolvableError)
    end

    it 'raises calculation unsolvable error if lower bound asymptote reached before f(input) = goal' do
      expect {
        goal = 0
        LinearSolver::solve_equal(goal, 1) do |input|
          input = 1 if input == 0
          0 / input + 1
        end
      }.to raise_exception(CalculationUnsolvableError)
    end

    it 'raises error if no code block given' do
      goal = 10
      starting_value = 5
      expect do
        LinearSolver::solve_equal(goal, starting_value)
      end.to raise_exception
    end

  end


  context 'given valid params' do

    context 'y = x/2 + 5' do
      before(:each) do
        def self.function(input)
          input / 2 + 5
        end

        @starting_value = 100
      end

      it 'solves for positive goal and positive input' do
        goal = 10
        input = LinearSolver::solve_equal(goal, @starting_value) do |input|
          self.function(input)
        end
        expect(input).to eql(10.000000000000002)
      end

      it 'solves for positive y and x = 0' do
        goal = 5
        input = LinearSolver::solve_equal(goal, @starting_value) do |input|
          self.function(input)
        end
        expect(input).to eql(0.0)
      end

      it 'solves for positive y and negative x' do
        starting_value = -100
        goal = 4
        input = LinearSolver::solve_equal(goal, starting_value) do |input|
          self.function(input)
        end
        expect(input).to eql(-1.9999999999999991)
      end

      it 'solves for y = 0 and negative x' do
        starting_value = -100
        goal = 0
        input = LinearSolver::solve_equal(goal, starting_value) do |input|
          self.function(input)
        end
        expect(input).to eql(-10.0)
      end

      it 'solves for negative y and negative x' do
        starting_value = -100
        goal = -10
        input = LinearSolver::solve_equal(goal, starting_value) do |input|
          self.function(input)
        end
        expect(input).to eql(-30.0)
      end

    end

    context 'y = x/2' do

      it 'solves for the origin (0,0)' do
        def self.function(input)
          input / 2
        end

        starting_value = -100
        goal = 0
        input = LinearSolver::solve_equal(goal, starting_value) do |input|
          self.function(input)
        end
        expect(input).to eql(0.0)
      end

    end

    context 'y = x/2 - 5' do
      before(:each) do
        def self.function(input)
          input / 2 - 5
        end

        @starting_value = 1
      end

      it 'solves goal = 0' do
        goal = 0
        input = LinearSolver::solve_equal(goal, @starting_value) do |input|
          self.function(input)
        end
        expect(input).to eql(10.0)
      end

      it 'solves positive x and negative y' do
        goal = -4
        input = LinearSolver::solve_equal(goal, @starting_value) do |input|
          self.function(input)
        end
        expect(input).to eql(2.0)
      end

      it 'solves x = 0 and negative y' do
        goal = -5
        input = LinearSolver::solve_equal(goal, @starting_value) do |input|
          self.function(input)
        end
        expect(input).to eql(0.0)
      end

      it 'solvers if starting value is 0' do
        goal = 10
        starting_value = 0
        input = LinearSolver::solve_equal(goal, starting_value) do |input|
          input
        end
        expect(input).to eql 10.0
      end

    end
  end

end