#!/usr/bin/env ruby

class LCCall < Struct.new(:left, :right)
  def replace(name, replacement)
    LCCall.new(left.replace(name, replacement), right.replace(name, replacement))
  end
 
	def reduce
		if left.reducible?
			LCCall.new(left.reduce, right)
		elsif right.reducible?
			LCCall.new(left, right.reduce)
		else
			left.call(right)
		end
	end

  def to_s
    "#{left}[#{right}]"
  end

	def callable?
		false
	end

	def reducible?
		left.reducible? || right.reducible? || left.callable?
	end

  def inspect
    to_s
  end
end
