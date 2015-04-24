def range(start, finish)
  return [finish] if start == finish

  [start] + range(start + 1, finish)
end

def sum_recursive(arr)
  return 0 if arr.length == 0

  arr[0] + sum_recursive(arr[1..-1])
end

def sum_iterative(arr)
  sum = 0

  arr.each do |el|
    sum += el
  end

  sum
end

def exp1(base, power)
  return 1 if power == 0

  base * exp(base, power - 1)
end



def exp2(base, power)
  if power.odd?
    return base if power == 1
    value = exp2( base, (power - 1) / 2 )
    base * value * value
  else
    return 1 if power == 0
    value = exp2(base, power / 2 )
    value * value
  end

end

class Array
  def deep_dup
    results = []
    self.each do |el|
      if !el.is_a?(Array)
        results << el
      elsif el == []
        results << Array.new
      else
        results << Array.new { deep_dup(el) }
      end
    end
    results
  end

end


def fib_recursive(n)
  if n == 1
    [1]
  elsif n == 2
    [1, 1]
  else
    fibs = fib_recursive(n - 1)
    fibs << fibs[-1] + fibs[-2]
  end
end

def fib_iterative(n)
  fibs = [1, 1]

  (3..n).each do |i|
    fibs << fibs[-1] + fibs[-2]
  end
  fibs
end


def bsearch(arr, target)
  return nil if arr.length == 1 && arr[0] != target
  middle_index = arr.length / 2
  if arr[middle_index] == target
    middle_index
  elsif arr[middle_index] < target
    recurse = bsearch(arr[middle_index+1..-1], target)
    return nil if recurse.nil?
    arr[0..middle_index].length + recurse

  elsif arr[middle_index] > target
    bsearch(arr[0...middle_index], target)
  end
end


if __FILE__ == $PROGRAM_NAME
  p bsearch([1, 2, 3], 1) # => 0
  p bsearch([2, 3, 4, 5], 3) # => 1
  p bsearch([2, 4, 6, 8, 10], 6) # => 2
  p bsearch([1, 3, 4, 5, 9], 5) # => 3
  p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
  p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
  p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
end
