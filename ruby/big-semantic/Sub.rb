#!/usr/bin/env ruby

require "./Number"

class Sub < Struct.new(:left, :right)
  def evaluate(environment)
    Number.new(left.evaluate(environment).value - right.evaluate(environment).valie)
  end

  def to_s
    "#{left} - #{right}"
  end

  def inspect
    "<<#{self}>>"
  end
end
