#!/usr/bin/env ruby

require "./Variable"
require "./Number"
require "./Boolean"
require "./Add"
require "./Sub"
require "./Divide"
require "./Multiply"
require "./LessThan"
require "./GreaterThan"
require "./If"
require "./While"
require "./For"
require "./Sequence"
require "./Assign"

puts Number.new(23).evaluate({})
puts Variable.new(:x).evaluate({x: Number.new(23)})

puts LessThan.new(
  Add.new(Variable.new(:x), Number.new(2)),
  Variable.new(:y)
).evaluate({
  x: Number.new(2),
  y: Number.new(3)
})

statement = Sequence.new(
  Assign.new(:x, Add.new(Number.new(1), Number.new(2))),
  Assign.new(:y, Add.new(Number.new(2), Number.new(3)))
)

puts statement

statement = statement.evaluate({})
puts statement

# TODO: fixed
# statement = For.new(
#   Assign.new(:x, Number.new(1)),
#   LessThan.new(Variable.new(:x), Number.new(10)),
#   Assign.new(:x, Add.new(Variable.new(:x), Number.new(1))),
#   Assign.new(:x, Add.new(Number.new(20), Variable.new(:x)))
# )

# puts statement
# statement = statement.evaluate({})
# puts statement

statement = While.new(
  LessThan.new(Variable.new(:x), Number.new(4)),
  Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
).evaluate({x: Number.new(1)})

puts statement
