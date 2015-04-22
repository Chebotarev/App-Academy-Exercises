class RpnCalc
  OPERATORS = ['+', '-', '*', '/']

  attr_accessor :stack

  def initialize
    @stack = []
  end

  def add_stack(el)
    if OPERATORS.include?(el)
      operate(el)
    else
      stack.push(el.to_i)
    end
  end

  def operate(op)
    raise "Not enough operands!" unless enough_operands?
    op.to_sym
    num1 = stack.pop
    num2 = stack.pop
    stack.push(num1.send(op, num2))
  end

  def enough_operands?
    stack.count >= 2
  end
end


if __FILE__ == $PROGRAM_NAME
  calculator = RpnCalc.new
  if ARGV[0]
    File.foreach(file) do |line|
      inputs = line.split
      inputs.each { |input| calculator.add_stack(input) }
    end
  else
    loop do
      input = gets.chomp
      break if input == '='
      calculator.add_stack(input)
    end
    p calculator.stack
  end
end
