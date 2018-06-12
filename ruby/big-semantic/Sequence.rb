#!/usr/bin/env ruby

class Sequence < Struct.new(:first, :second)
  def evaluate(environment)
    second.evaluate(first.evaluate(environment))
  end

  def to_s
    "#{first}; #{second};"
  end

  def inspect
    "<<#{self}>>"
  end
end
