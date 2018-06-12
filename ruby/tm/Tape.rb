#!/usr/bin/env ruby

class Tape < Struct.new(:left, :middle, :right, :blank)
  def inspect
    "#<Tape #{left.join}(#{middle})#{right.join}> "
  end

  def to_s
    inspect
  end

  def write(character)
    Tape.new(left, character, right, blank)
  end

  def move_head_left
    Tape.new(left[0..-2], left.last || blank, [middle] + right)
  end

  def move_head_right
    Tape.new(left + [middle], right.first || blank, right.drop(1), blank)
  end
end

tape = Tape.new(['1', '0', '1'], '1', [], '_')
puts tape
puts tape.move_head_left()
puts tape.write('0')
