#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require_relative "primitive"

class LessThan < Struct.new(:left, :right)
  def to_s
    "#{left} < #{right}"
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      LessThan.new(left.reduce(environment), right)
    elsif right.reducible?
      LessThan.new(left, right.reduce(environment))
    else
      Boolean.new(left.value < right.value)
    end
  end
end

class GreaterThan < Struct.new(:left, :right)
  def to_s
    "#{left} > #{right}"
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      GreaterThan.new(left.reduce(environment), right)
    elsif right.reducible?
      GreaterThan.new(left, right.reduce(environment))
    else
      Boolean.new(left.value > right.value)
    end
  end
end

class If < Struct.new(:condition, :consequence, :alternative)
  def to_s
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end

  def inspect
    "<#{self}>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if condition.reducible?
      [If.new(condition.reduce(environment), consequence, alternative), environment]
    else
      case condition
      when Boolean.new(true)
        [consequence, environment]
      when Boolean.new(false)
        [alternative, environment]
      end
    end
  end
end
