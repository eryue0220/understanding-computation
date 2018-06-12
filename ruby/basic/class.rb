# !/usr/bin/env ruby

class Point
  def initialize(x, y)
    @x = x
    @y = y
  end

  def getX
    @x
  end

  def getY
    @y
  end

  def +(other)
    Point.new(@x + other.getX, @y + other.getY)
  end

  def inspect
    "#<Point (#{@x}, #{@y})>"
  end
end

a = Point.new(2, 3)
b = Point.new(10, 20)

a + b

puts "#{Point.new(4, 5) == Point.new(4, 5)}"
