#!/usr/bin/env ruby

require_relative 'SKI'
require_relative 'SKICall'
require_relative 'SKISymbol'

class SKICombinator < SKISymbol
	def callable?(*arguments)
		arguments.length == method(:call).arity
	end

  def as_a_function_of(name)
    SKICall.new(K, self)
  end
end
