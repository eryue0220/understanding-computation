#!/usr/bin/env ruby

class Assign < Struct.new(:name, :expression)
  def to_ruby
    "-> e { e.merge({ #{name.inspect} => (#{expression.to_ruby}).call(e) }) }"
  end

  def to_s
   "#{name} = #{expression}"
  end

  def inspect
    "<<#{self}>>"
  end
end
