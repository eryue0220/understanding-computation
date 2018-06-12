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

  def follow_rules_for(state, character)
    rules_for(state, character).map(&:follow)
  end

  def rules_for(state, character)
    rules.select { |rule| rule.applies_to?(state, character) }
  end
end

class NFA < Struct.new(:current_states, :accept_states, :rulebook)
  def accepting?
    (current_states & accept_states).any?
  end

  def read_character(character)
    self.current_states = rulebook.next_states(current_states, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end
end

class NFAGenerator < Struct.new(:start_state, :accpet_states, :rulebook)
  def to_nfa
    NFA.new(Set[start_state], accpet_states, rulebook)
  end

  def accpets?(string)
    to_nfa.tap { |nfa| nfa.read_string(string) }.accpets?
  end
end

rule = NFARule.new([
  FARule.new(1, 'a', 1),
  FARule.new(1, 'b', 1),
  FARule.new(1, 'b', 2),
  FARule.new(2, 'a', 3),
  FARule.new(2, 'b', 3),
  FARule.new(3, 'a', 4),
  FARule.new(3, 'b', 4)
])

puts rule.next_states(Set[1], 'b')
puts rule.next_states(Set[1, 2], 'b')
puts rule.next_states(Set[1, 3], 'a')

puts NFA.new(Set[1], [4], rule).accepting?
puts NFA.new(Set[1, 2, 4], [4], rule).accepting?

nfa = NFA.new(Set[1], [4], rule)
puts nfa.accepting?
nfa.read_string('baa')
puts nfa.accepting?
