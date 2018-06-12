#!/usr/bin/env ruby

require "./Boolean"
require "./Number"
require "./DoNothing"
require "./Assign"
require "./Variable"
require "./Add"
require "./Sub"
require "./Multiply"
require "./Divide"
require "./If"
require "./LessThan"
require "./GreaterThan"
require "./Sequence"
require "./While"

puts Number.new(5).to_ruby
puts eval(Number.new(5).to_ruby).call({})

puts Add.new(Variable.new(:x), Number.new(1)).to_ruby
puts LessThan.new(Add.new(Variable.new(:x), Number.new(1)), Number.new(3)).to_ruby

environment = {x: 3}

puts eval(Add.new(Variable.new(:x), Number.new(1)).to_ruby).call(environment)
puts eval(
  LessThan.new(Add.new(Variable.new(:x), Number.new(1)), Number.new(3)).to_ruby
).call(environment)

statement = While.new(
  LessThan.new(Variable.new(:x), Number.new(4)),
  Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3)))
)

puts statement.to_ruby
puts eval(statement.to_ruby).call({x: 1})
