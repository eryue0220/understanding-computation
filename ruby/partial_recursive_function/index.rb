#!/usr/bin/env ruby

def zero
	0
end

def two
	2
end

def three
	3
end

def increment(n)
	n + 1
end

def recurse(f, g, *values)
	*other_values, last_value = *values

	if last_value.zero?
		send(f, *other_values);
	else
		easier_last_value = last_value - 1
		easier_values = other_values + [easier_last_value]
		easier_result = recurse(f, g, *easier_values)
		send(g, *easier_values, easier_result);
	end
end

def add_zero_to_x(x)
	x
end

def increment_easier_result(x, easier_y, easier_result)
	increment(easier_result)
end

def add(x, y)
	recurse(:add_zero_to_x, :increment_easier_result, x, y)
end

puts add(two, three)

