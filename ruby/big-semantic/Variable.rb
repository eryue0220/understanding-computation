#!/usr/bin/env ruby

class Variable < Struct.new(:name)
  def evaluate(environment)
    environment[name]
  end

  def to_s
    name.to_s
  end

  def inspect
    "<<#{self}>>"
  end
end
