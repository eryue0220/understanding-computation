#! /usr/bin/env ruby

require "./boolean"
require "./number"
require "./pair"

def to_integer(proc)
  proc[-> n { n + 1 }][0]
end

def to_boolean(proc)
  IF[proc][true][false]
end

puts to_integer(ZERO)
puts to_integer(TWO)
puts to_boolean(TRUE)
puts to_boolean(FALSE)
puts to_boolean(IS_ZERO[ZERO])
