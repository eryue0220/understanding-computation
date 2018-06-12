#!/usr/bin/env ruby

 class DoNothing
  def to_ruby
    "-> e { e }"
  end

  def to_s
    "do-nothing"
  end

  def inspect
    "<<#{self}>>"
  end
end
