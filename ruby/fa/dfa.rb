#!/usr/bin/env ruby

class FARule < Struct.new(:state, :character, :next_state)
  def applies_to?(state, character)
    self.state == state && self.character == character
  end

  def follow
    next_state
  end

  def inspect
    "#<FARule #{state.inspect} --#{character} --> #{next_state.inspect}>"
  end
end

class DFARule < Struct.new(:rules)
  def next_state(state, character)
    rule_for(state, character).follow
  end

  def rule_for(state, character)
    rules.detect { |rule| rule.applies_to?(state, character) }
  end
end

class DFA < Struct.new(:current_state, :accept_state, :rulebook)
  def accepting?
    accept_state.include?(current_state)
  end

  def read_character(character)
    self.current_state = rulebook.next_state(current_state, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end
end

class DFAGenerator < Struct.new(:start_state, :end_state, :rulebook)
  def to_dfa
    DFA.new(start_state, end_state, rulebook)
  end

  def accept?(string)
    to_dfa.tap { |dfa| dfa.read_string(string) }.accepting?
  end
end

rulebook = DFARule.new([
  FARule.new(1, 'a', 2),
  FARule.new(1, 'b', 1),
  FARule.new(2, 'a', 2),
  FARule.new(2, 'b', 3),
  FARule.new(3, 'a', 3),
  FARule.new(3, 'b', 3)
])

puts rulebook.next_state(1, 'a')
puts rulebook.next_state(1, 'b')
puts rulebook.next_state(2, 'b')
puts DFA.new(1, [1, 3]).accepting?
puts DFA.new(1, [2, 3]).accepting?
puts DFA.new(1, [3], rulebook).tap { |dfa| dfa.read_string('baaab') }.accepting?

dfa_design = DFAGenerator.new(1, [3], rulebook)
puts dfa_design.accept?('a')
puts dfa_design.accept?('baa')
puts dfa_design.accept?('baab')
  