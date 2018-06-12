#!/usr/bin/env ruby

require "./Boolean"

class GreaterThan < Struct.new(:left, :right)
  def evaluate(environment)
    Boolean.new(left.evaluate(environment).value > right.evaluate(environment).value)
  end

  def to_s
    "#{left} > #{right}"
  end

  def inspect
    "<<#{self}>>"
  end
end
