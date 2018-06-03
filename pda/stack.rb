#!/usr/bin/env ruby

class Stack < Struct.new(:contents)
  def push(character)
    Stack.new([character] + contents)
  end

  def pop
    Stack.new(contents.drop(1))
  end

  def top
    contents.first
  end

  def inspect
    "#<Stack (#{top})#{contents.drop(1).join}>"
  end
end

stack = Stack.new(['a', 'b', 'c', 'd', 'e', 'f'])
puts stack

stack = Stack.new(['$']).push('x').push('y').push('z')
puts stack.top