#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class Number < Struct.new(:value)
  def to_s
    value.to_s
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    false
  end
end

class Boolean < Struct.new(:value)
  def to_s
    value.to_s
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    false
  end
end

class DoNothing < Struct.new(:value)
  def to_s
    'do-nothing'
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
end

class Variable < Struct.new(:name)
  def to_s
    name.to_s
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
end
