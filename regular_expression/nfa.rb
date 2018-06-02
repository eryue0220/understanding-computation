#!/usr/bin/env ruby

require 'set'

class FARule < Struct.new(:current_state, :character, :next_state)
  def applies_to?(state, character)
    self.current_state == state && self.character == character
  end

  def follow
    next_state
  end
end

class NFARule < Struct.new(:rules)
  def next_states(states, character)
    states.flat_map { |state| follow_rules_for(state, character) }.to_set
  end

  def follow_free_move(states)
    more_states = next_states(states, nil)

    if more_states.subset?(states)
      states
    else
      follow_free_move(states + more_states)
    end
  end

  def follow_rules_for(state, character)
    rules_for(state, character).map(&:follow)
  end

  def rules_for(state, character)
    rules.select { |rule| rule.applies_to?(state, character) }
  end
end

class NFA < Struct.new(:current_states, :accept_states, :rule)
  def accepts?
    (current_states & accept_states).any?
  end

  def current_states
    rule.follow_free_move(super)
  end

  def read_character(character)
    self.current_states = rule.next_states(current_states, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end
end

class NFAGenerator < Struct.new(:start_state, :accept_states, :rule)
  def to_nfa
    NFA.new(Set[start_state], accept_states, rule)
  end

  def accepts?(string)
    to_nfa.tap { |nfa| nfa.read_string(string) }.accepts?
  end
end
