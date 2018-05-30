#!/usr/bin/env ruby

class Sequence < Struct.new(:first, :second)
  def to_ruby
    "-> e { (#{second}).call((#{first}).call(e)) }"
  end

  def to_s
    "#{first}; #{second}"
  end

  def inspect
    "<<#{self}>>"
  end
end
