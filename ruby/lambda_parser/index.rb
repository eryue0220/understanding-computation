#!/usr/bin/env ruby

require "./LCCall"
require "./LCFunction"
require "./LCVariable"

one = LCFunction.new(:p,
    LCFunction.new(:x,
      LCCall.new(
        LCVariable.new(:p), LCVariable.new(:x)
      )
    )
  )

puts one

expression = LCVariable.new(:x)
puts expression

expression = expression.replace(:x, LCFunction.new(:y, LCVariable.new(:y)))
puts expression

expression = expression.replace(:z, LCFunction.new(:y, LCVariable.new(:y)))
puts expression

expression = LCFunction.new(:x,
  LCCall.new(LCVariable.new(:x), LCVariable.new(:y))
)

puts expression

replacement = LCCall.new(LCVariable.new(:z), LCVariable.new(:x))
expression = expression.replace(:y, replacement)
puts expression

increment = LCFunction.new(:n,
				LCFunction.new(:p,
					LCFunction.new(:x,
						LCCall.new(
							LCVariable.new(:p),
							LCCall.new(
								LCCall.new(LCVariable.new(:n), LCVariable.new(:p)),
								LCVariable.new(:x)
							)
						)
					)
				)
			)

add = LCFunction.new(:m,
	LCFunction.new(:n,
		LCCall.new(LCCall.new(LCVariable.new(:n), increment), LCVariable.new(:m))
	)
)
			
expression = LCCall.new(LCCall.new(add, one), one)

#while expression.reducible?
#	puts expression
#	expression = expression.reduce
#end

puts expression

incr, zero = LCVariable.new(:incr), LCVariable.new(:zero)

expression = LCCall.new(LCCall.new(expression, incr), zero)

while expression.reducible?
	puts expression
	expression = expression.reduce
end

puts expression
