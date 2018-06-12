#!/usr/bin/env ruby

class If < Struct.new(:condition, :consequence, :alternative)
  def to_ruby
    "-> e { if (#{condition}).call(e)" +
      " then (#{consequence}).call(e)" +
      " else (#{alternative}).call(e)" +
      " end }"
  end

  def to_s
    "if (#{condition}) then #{consequence} else #{alternative}"
  end

  def inspect
    "<<#{self}>>"
  end
end
