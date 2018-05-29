#!/usr/bin/env ruby

require "./Number"
require "./Variable"
require "./Add"
require "./Sub"
require "./Multiply"
require "./Divide"
require "./LessThan"
require "./GreaterThan"
require "./Assign"
require "./If"
require "./While"
require "./Sequence"
require "./Machine"
require "./StatementMachine"

operator = Add.new(
  Multiply.new(Number.new(1), Number.new(2)),
  Multiply.new(Number.new(3), Number.new(4))
)

expression = Add.new(
  Multiply.new(Number.new(1), Number.new(2)),
  Multiply.new(Number.new(3), Number.new(4))
)

Machine.new(
  Add.new(
    Multiply.new(Number.new(1), Number.new(2)),
    Multiply.new(Number.new(3), Number.new(4))
  )
).run

Machine.new(
  LessThan.new(Number.new(3), Add.new(Number.new(2), Number.new(2)))
).run

Machine.new(
  GreaterThan.new(Number.new(3), Add.new(Number.new(2), Number.new(2)))
).run

Machine.new(
  Divide.new(
    Add.new(Number.new(2), Number.new(2)),
    Number.new(2)
  )
).run

Machine.new(Sub.new(Number.new(4), Number.new(2))).run

Machine.new(
  Add.new(Variable.new(:x), Variable.new(:y)),
  {x: Number.new(3), y: Number.new(4)}
).run

StatementMachine.new(
  Assign.new(:x, Add.new(Variable.new(:x), Number.new(2))),
  {x: Number.new(1)}
).run

StatementMachine.new(
  If.new(
    Variable.new(:x),
    Assign.new(:y, Number.new(1)),
    Assign.new(:y, Number.new(2))
  ),
  {x: LessThan.new(Number.new(2), Number.new(0))}
).run


StatementMachine.new(
  If.new(
    Variable.new(:x),
    Assign.new(:y, Number.new(1)),
    If.new(
      LessThan.new(Number.new(1), Number.new(2)),
      Assign.new(:y, Number.new(3)),
      Assign.new(:y, Number.new(4))
    )
  ),
  {x: GreaterThan.new(Number.new(3), Number.new(5))}
).run

StatementMachine.new(
  Sequence.new(
    Assign.new(:x, Add.new(Number.new(1), Number.new(2))),
    Assign.new(:y, Add.new(Variable.new(:x), Number.new(3)))
  ),
  {}
).run

StatementMachine.new(
  While.new(
    LessThan.new(Variable.new(:x), Number.new(5)),
    Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(5)))
  ),
  {x: Number.new(1)}
).run
