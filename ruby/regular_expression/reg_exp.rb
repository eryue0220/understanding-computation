#!/usr/bin/env ruby

require './nfa'

module Pattern
  def bracket(outer_precedence)
    if precedence < outer_precedence
      '(' + to_s + ')'
    else
      to_s
    end
  end

  def inspect
    "/#{self}/"
  end

  def match?(string)
    to_nfa.accepts?(string)
  end
end

class Empty
  include Pattern

  def to_s
    ''
  end

  def precedence
    3
  end

  def to_nfa
    start_state = Object.new
    accept_states = [start_state]
    rule = NFARule.new([])

    NFAGenerator.new(start_state, accept_states, rule)
  end
end

class Literal < Struct.new(:character)
  include Pattern

  def to_s
    character
  end

  def precedence
    3
  end

  def to_nfa
    start_state = Object.new
    accept_states = Object.new
    rule = FARule.new(start_state, character, accept_states)
    rulebook = NFARule.new([rule])
    NFAGenerator.new(start_state, [accept_states], rulebook)
  end
end

class Concatenate < Struct.new(:first, :second)
  include Pattern

  def to_s
    [first, second].map { |pattern| pattern.bracket(precedence) }.join
  end

  def precedence
    1
  end

  def to_nfa
    first_nfa = first.to_nfa
    second_nfa = second.to_nfa
    start_state = first_nfa.start_state
    accept_states = second_nfa.accept_states
    rules = first_nfa.rule.rules + second_nfa.rule.rules
    extra_rules = first_nfa.accept_states.map { |state|
      FARule.new(state, nil, second_nfa.start_state)
    }

    rulebook = NFARule.new(rules + extra_rules)
    NFAGenerator.new(start_state, accept_states, rulebook)
  end
end

class Choose < Struct.new(:first, :second)
  include Pattern

  def to_s
    [first, second].map { |pattern| pattern.bracket(precedence) }.join('|')
  end

  def precedence
    0
  end

  def to_nfa
    first_nfa = first.to_nfa
    second_nfa = second.to_nfa
    start_state = Object.new
    accept_states = first_nfa.accept_states + second_nfa.accept_states
    rules = first_nfa.rule.rules + second_nfa.rule.rules
    extra_rules = [first_nfa, second_nfa].map { |nfa|
      FARule.new(start_state, nil, nfa.start_state)
    }
    rulebook = NFARule.new(rules + extra_rules)

    NFAGenerator.new(start_state, accept_states, rulebook)
  end
end

class Repeat < Struct.new(:pattern)
  include Pattern

  def to_s
    pattern.bracket(precedence) + '*'
  end

  def precedence
    2
  end

  def to_nfa
    pattern_nfa = pattern.to_nfa
    start_state = Object.new
    accept_states = pattern_nfa.accept_states + [start_state]
    rules = pattern_nfa.rule.rules
    extra_rules = pattern_nfa.accept_states.map { |accept_state|
      FARule.new(accept_state, nil, pattern_nfa.start_state)
    } +
    [FARule.new(start_state, nil, pattern_nfa.start_state)]
    rulebook = NFARule.new(rules + extra_rules)
    NFAGenerator.new(start_state, accept_states, rulebook)
  end
end

pattern = Repeat.new(
  Choose.new(
    Concatenate.new(Literal.new('a'), Literal.new('b')),
    Literal.new('a')
  )
)

puts pattern
nfa = Empty.new.to_nfa
puts nfa
puts nfa.accepts?('')
nfa = Literal.new('a').to_nfa
puts nfa.accepts?('')
puts nfa.accepts?('a')
puts nfa.accepts?('b')

puts Concatenate.new(Literal.new('a'), Literal.new('b')).match?('a')
puts Concatenate.new(
  Literal.new('a'),
  Concatenate.new(
    Literal.new('a'),
    Literal.new('c')
  )
).match?('ab')

puts Concatenate.new(
  Literal.new('a'),
  Concatenate.new(
    Literal.new('b'),
    Literal.new('c')
  )
).match?('abc')

pattern = Choose.new(Literal.new('a'), Literal.new('b'))
puts pattern.match?('a')
puts pattern.match?('b')
puts pattern.match?('c')

pattern = Repeat.new(Literal.new('a'))
puts pattern.match?('')
puts pattern.match?('a')
puts pattern.match?('aaa')
puts pattern.match?('abbb')