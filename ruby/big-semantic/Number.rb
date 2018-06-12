#!/usr/bin/env ruby

class Number < Struct.new(:value)
  def evaluate(environment)
    self
  end

  def to_s
    value.to_s
  end

  def inspect
    "<<#{self}>>"
  end
end
