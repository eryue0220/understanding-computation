#!/usr/bin/env ruby

class Assign < Struct.new(:name, :expression)
  def evaluate(environment)
    environment.merge({ name => expression.evaluate(environment) })
  end

  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "<<#{self}>>"
  end
end
