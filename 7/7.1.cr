abstract class Component
  def value(circuit)
    @cached_value ||= compute_value(circuit)
  end

  abstract def compute_value(circuit)
end

class FixedValue < Component
  def initialize(@value : UInt16)
  end

  def compute_value(circuit)
    @value
  end
end

class Wire < Component
  def initialize(@name : String)
  end

  def compute_value(circuit)
    circuit.value_of(@name)
  end
end

abstract class Binary < Component
  def initialize(@left : Component, @right : Component)
  end

  def compute_value(circuit)
    op(@left.value(circuit), @right.value(circuit))
  end

  abstract def op(left, right)
end

class And < Binary
  def op(left, right)
    left & right
  end
end

class Or < Binary
  def op(left, right)
    left | right
  end
end

class RShift < Binary
  def op(left, right)
    left >> right
  end
end

class LShift < Binary
  def op(left, right)
    left << right
  end
end

abstract class Unary < Component
  def initialize(@component : Component)
  end

  def compute_value(circuit)
    op(@component.value(circuit))
  end

  abstract def op(value)
end

class Not < Unary
  def op(value)
    ~value
  end
end

class Nop < Unary
  def op(value)
    value
  end
end

class Circuit
  def initialize
    @wires = {} of String => Component
  end

  def unary(op, exp, output)
    connect op.new(parse_input(exp)), output
  end

  def binary(op, left, right, output)
    connect op.new(parse_input(left), parse_input(right)), output
  end

  def value_of(wire : String)
    @wires[wire].value(self)
  end

  def connect(input, output)
    @wires[output] = input
  end

  def parse_input(string)
    if integer = string.to_u16?
      FixedValue.new(integer)
    else
      Wire.new(string)
    end
  end
end

circuit = Circuit.new

input = File.read("#{__DIR__}/input")
input.each_line do |line|
  case line
  when /(.+) AND (.+) -> (\w+)/
    circuit.binary And, $1, $2, $3
  when /(.+) OR (.+) -> (\w+)/
    circuit.binary Or, $1, $2, $3
  when /(.+) RSHIFT (.+) -> (\w+)/
    circuit.binary RShift, $1, $2, $3
  when /(.+) LSHIFT (.+) -> (\w+)/
    circuit.binary LShift, $1, $2, $3
  when /NOT (.+) -> (\w+)/
    circuit.unary Not, $1, $2
  when /(.+) -> (\w+)/
    circuit.unary Nop, $1, $2
  end
end

puts circuit.value_of("a")
