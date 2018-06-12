#!/usr/bin/env ruby

class While < Struct.new(:condition, :body)
  def to_ruby
    "-> e {" + 
      " while (#{condition.to_ruby}).call(e); e = (#{body.to_ruby}).call(e); end;" +
      " e " +
      " } "
  end

  def to_s
    "While (#{condition}) { #{body} }"
  end

  def inspect
    "<<#{self}>>"
  end
end
