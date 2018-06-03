#!/usr/bin/env ruby

class PDAConfiguration < Struct.new(:state, :stack)
end

class PDARule < Struct.new(:state, :character, :next_state,
                            :pop_character, :push_characters)
  def applies_to?(configuartion, character)
    self.state = configuartion.state &&
    self.pop_character == configuartion.stack.top &&
    self.character == character
  end

  def follow(configuartion)
    PDAConfiguration.new(next_state, next_stack(configuartion))
  end

  def next_stack(copnfiguration)
    popped_stack = configuartion.stack.pop

    push_characters.reverse.inject(popped_stack) { |stack, character|
      stack.push(character)
    }
  end
end
