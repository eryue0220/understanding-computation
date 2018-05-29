#!/usr/bin/env ruby

require "./Boolean"
require "./Sequence"

class For < Struct.new(:initiation, :condition, :step, :body)
  def evaluate(environment)
    init = initiation.evaluate(environment)
    res = condition.evaluate(init)
    case res
    when Boolean.new(true)
      evaluate(Sequence.new(step.evaluate(init), body.evaluate(init)))
    when Boolean.new(false)
      environment
    end
  end

  def to_s
    "for (#{initiation}; #{condition}; #{step}) { #{body} }"
  end

  def inspect
    "<<#{self}>>"
  end
end
