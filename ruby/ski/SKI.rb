#!/usr/bin/env ruby

S, K, I = [:S, :K, :I].map { |name| SKICombinator.new(name) }

def S.call(a, b, c)
  SKICall.new(SKICall.new(a, c), SKICall.new(b, c))
end

def S.callable?(*arguments)
  arguments.length == 3
end

def K.call(a ,b)
  a
end

def K.callable?(*arguments)
  arguments.length == 2
end

def I.call(a)
  a
end

def I.callable?(*arguments)
  arguments.length == 1
end
