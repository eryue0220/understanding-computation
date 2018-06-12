#!/usr/bin/env ruby

require "./Number"

class Divide < Struct.new(:left, :right)
  def evaluate(environment)
    Number.new(left.evaluate(environment).value / right.evaluate(environment).value)
  end

  def to_s
    "#{left} / #{right}"
  end

  def inspect
    "<<#{self}>>"
  end
end
