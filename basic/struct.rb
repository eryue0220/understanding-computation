#!/usr/bin/env ruby

class Point < Struct.new(:x, :y)
  def +(other)
    Point.new(x + other.x, y + other.y)
  end

  def inspect
    "#<Point (#{x}, #{y})>"
  end
end

a = Point.new(2, 3)
b = Point.new(10, 20)

a + b

puts "#{Point.new(4, 5) == Point.new(4, 5)}"
