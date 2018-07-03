#!/usr/bin/env ruby

class LCVariable < Struct.new(:name)
  def replace(name, replacement)
    if self.name == name
      replacement
    else
      self
    end
  end

	def callable?
		false
	end

	def reducible?
		false
	end

  def to_s
    name.to_s
  end

  def inspect
    to_s
  end
end
