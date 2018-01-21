#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require_relative "primitive"

class Add < Struct.new(:left, :right)
  def to_s
    "#{left} + #{right}"
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      Add.new(left.reduce(environment), right)
    elsif right.reducible?
      Add.new(left, right.reduce(environment))
    else
      Number.new(left.value + right.value)
    end
  end
end

class Sub < Struct.new(:left, :right)
  def to_s
    "#{left} - #{right}"
  end

  def inspec
    "<#{self}>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      Sub.new(left.reduce(environment), right)
    elsif right.reducible?
      Sub.new(left, right.reduce(environment))
    else
      Number.new(left.value - right.value)
    end
  end
end

class Multiply < Struct.new(:left, :right)
  def to_s
    "#{left} * #{right}"
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      Multiply.new(left.reduce(environment), right)
    elsif right.reducible?
      Multiply.new(left, right.reduce(environment))
    else
      Number.new(left.value * right.value)
    end
  end
end

class Assign < Struct.new(:name, :expression)
  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if expression.reducible?
      [Assign.new(name, expression.reduce(environment)), environment]
    else
      [DoNothing.new, environment.merge({ name => expression })]
    end
  end
end
