#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class Number < Struct.new(:value)
  def to_s
    value.to_s
  end

  def to_ruby
    "-> e { #{value.inspect} }"
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    false
  end

  def evaluate(environment)
    self
  end
end

class Boolean < Struct.new(:value)
  def to_s
    value.to_s
  end

  def to_ruby
    "-> e { #{value.inspect} }"
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    false
  end

  def evaluate(environment)
    self
  end
end

class DoNothing < Struct.new(:value)
  def to_s
    'do-nothing'
  end

  def to_ruby
    "-> e { e }"
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    false
  end

  def ==(other_statement)
    other_statement.instance_of?(DoNothing)
  end

  def evaluate(environment)
    environment
  end
end

class Variable < Struct.new(:name)
  def to_s
    name.to_s
  end

  def to_ruby
    "-> e { e[#{name.inspect}] }"
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    environment[name]
  end

  def evaluate(environment)
    environment[name]
  end
end
