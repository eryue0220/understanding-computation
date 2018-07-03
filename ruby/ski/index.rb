#!/usr/bin/env ruby

require_relative 'SKI'
require_relative 'SKICall'
require_relative 'SKISymbol'
require_relative 'SKICombinator'

x, y, z = SKISymbol.new(:x), SKISymbol.new(:y), SKISymbol.new(:z)
# expression = SKICall.new(SKICall.new(SKICall.new(S, x), y), z)
# combinator = expression.left.left.left
# puts combinator
# first_argument = expression.left.left.right
# puts first_argument

swap = SKICall.new(SKICall.new(S, SKICall.new(K, SKICall.new(S, I))), K)
expression = SKICall.new(SKICall.new(swap, x), y)
puts expression

while expression.reducible?
  puts expression
  expression = expression.reduce
end

puts expression
