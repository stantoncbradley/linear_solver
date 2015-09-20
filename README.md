# LinearSolver

Given y in y = f(x), solves for x in log(n) time.

## Installation

Add this line to your application's Gemfile:

    gem 'linear_solver'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install linear_solver

## Usage

Use the linear solver when it is difficult/inconvenient/impossible to invert y = f(x) to solve for x.<br />
*Notes:<br />
1. this gem only solves for linear equations, and thus only returns one value.  For example, given y = x^2, solving for y = 16 will return EITHER 4 OR -4 (depending on the starting value provided).<br />
2. linear solver cannot handle formula specific edge-cases (like divide by 0).  If the equation you provide has invalid cases, you must be responsible for handling them yourself.<br />

Linear solver works in 5 steps:<br />
1. Evaluate x = 0.0 case.  This eliminates solving for the 0 limit, of which the solver only approaches.<br />
2. Convert starting_value to 1 if it is 0.  The solver works by iteratively multiplying and dividing this value, so it cannot be 0.<br />
3. Determine whether x will be greater than or less than 0. The solver needs to know if the bounds are -infinity to 0 or 0 to infinity.<br />
4. Determine upper limit (toward +/-infinity) by iteratively multiplying by 2 until f(x) > goal (< goal if x is negative).<br />
5. Iteratively decrease and increase x by 1/2 step intervals until stopping condition is satisfied (hence log(n) performance).<br />

Linear solver has two methods:

<b>solve_equal</b> solves for x using (y == goal).  For example:

```
def f(x)
    2 * x
end
goal = 10
starting_value = 0
LinearSolver::solve_equal(goal, starting_value) do |result|
    y = f(result)
end
```
LinearSolver will return 5.

For more flexibility, the method <b>solve_with_stopper</b> takes a lamdba expression in the form of<br />
```->(output,goal){ conditional expression }```
which allows custom rules for solving the equation.  Example:

```
def f(x)
    2 * x
end
goal = 10
starting_value = 0
LinearSolver::solve_with_stopper(goal, starting_value, ->(output, goal) { output > goal }) do |result|
    y = f(result)
end
```
In this case, LinearSolver will return the first value it generates that satisfies f(x) > 10.

## Contributing

1. Fork it ( https://github.com/stantoncbradley/linear_solver/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
