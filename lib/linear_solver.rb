require "linear_solver/version"

module LinearSolver

  # raised when linear solver reaches upper limit or asymptote limit
  class CalculationUnsolvableError < StandardError

  end

  def self.solve_equal(goal, starting_value, &block)
    self.solve_with_stopper(goal, starting_value, ->(a, b) { a == b }, &block)
  end

  def self.solve_with_stopper(goal, starting_value, stopping_comparator, &block)
    raise StandardError unless block_given?

    return 0.0 if stopping_comparator.call(block.call(0.0), goal)

    starting_value = 1 if starting_value == 0
    starting_value = starting_value.to_f
    goal = goal.to_f

    block.call(0) < goal ? input = starting_value.abs : input = -(starting_value.abs)

    upper_bounds_counter = 0
    if input < 0
      while block.call(input) > goal && upper_bounds_counter < 10000
        input *= 2
        upper_bounds_counter += 1
      end
    else
      while block.call(input) < goal && upper_bounds_counter < 10000
        input *= 2
        upper_bounds_counter += 1
      end
    end
    raise CalculationUnsolvableError.new("Upper bound reached, goal: #{goal}, starting value: #{starting_value}, input: #{input}") if upper_bounds_counter >= 10000

    output = block.call(input)
    unless stopping_comparator.call(output, goal)
      difference = input.abs
      asymptote_counter = 0
      begin
        difference /= 2
        input += difference if output < goal
        input -= difference if output > goal
        asymptote_counter += 1
        output = block.call(input)
      end until (stopping_comparator.call(output, goal) || asymptote_counter == 10000)
      raise CalculationUnsolvableError.new("Lower bound asymptote reached, goal: #{goal}, starting value: #{starting_value}, input: #{input}") if asymptote_counter == 10000
    end
    return input
  end

end
