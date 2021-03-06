#!/usr/bin/env ruby

class Boolean < Struct.new(:value)
  def to_ruby
    " -> e { #{value} }"
  end

  def to_s
    value.to_s
  end

  def inspect
    "<<#{self}>>"
  end
end
