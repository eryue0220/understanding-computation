#!/usr/bin/env ruby

require "./DoNothing"
require "./If"
require "./Sequence"

class While < Struct.new(:condition, :body)
  def to_s
    "While (#{condition}) { #{body} }"
  end

  def inspect
    "#{self}"
  end

  def reducible?
    true
  end

  def reduce(environment)
    puts "self ===> #{self}"
    [If.new(condition, Sequence.new(body, self), DoNothing.new), environment]
  end
end
