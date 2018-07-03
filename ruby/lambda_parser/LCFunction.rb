#!/usr/bin/env ruby

class LCFunction < Struct.new(:parameter, :body)
  def replace(name, replacement)
    if self.parameter == name
      self
    else
      LCFunction.new(parameter, body.replace(name, replacement))
    end
  end

  def call(argument)
    body.replace(parameter, argument)
  end

  def callable?
		true
	end

	def reducible?
		false
	end

	def to_s
    "-> #{parameter} { #{body} }"
  end

  def inspect
    to_s
  end
end
