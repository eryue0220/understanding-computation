#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require_relative "condition"
require_relative "operation"
require_relative "primitive"
require_relative "sequence"

class Machine < Struct.new(:statement, :environment)
  def step
    self.statement, self.environment = statement.reduce(environment)
  end

  def run
    while statement.reducible?
      puts "#{statement}, #{environment}"
      step
    end
    puts "#{statement}, #{environment}"
  end
end
