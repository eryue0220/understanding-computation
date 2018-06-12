#!/usr/bin/env ruby

require './stack'

class PDAConfiguration < Struct.new(:state, :stack)
end

class PDARule < Struct.new(:state, :character, :next_state,
                            :pop_character, :push_characters)
  def applies_to?(configuration, character)
    self.state = configuration.state &&
    self.pop_character == configuration.stack.top &&
    self.character == character
  end

  def follow(configuration)
    PDAConfiguration.new(next_state, next_stack(configuration))
  end

  def next_stack(configuration)
    popped_stack = configuration.stack.pop

    push_characters.reverse.inject(popped_stack) { |stack, character|
      stack.push(character)
    }
  end
end

class DPDARulebook < Struct.new(:rules)
  def next_configuration(configuration, character)
    rule_for(configuration, character).follow(configuration)
  end

  def rule_for(configuration, character)
    rules.detect { |rule| rule.applies_to?(configuration, character) }
  end

  def applies_to?(configuration, character)
    !rule_for(configuration, character).nil?
  end

  def follow_free_move(configuration)
    if applies_to?(configuration, nil)
      follow_free_move(next_configuration(configuration, nil))
    else
      configuration
    end
  end
end

class DPDA < Struct.new(:current_confiuration, :accept_states, :rulebook)
  def accepting?
    accept_states.include?(current_confiuration.state)
  end

  def read_character(character)
    self.current_confiuration =
      rulebook.next_configuration(current_confiuration, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end
end
