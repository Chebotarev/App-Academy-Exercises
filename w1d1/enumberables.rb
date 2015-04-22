def mult_by_two(arr)
  arr.map { |x| x * 2 }
end

class Array
  def my_each &proc
    self.length.times do |iter|
      proc.call self[iter]
    end
  end
end

# [2,3,4].my_each{ |el| p el }


#[1,2,3,4,5]
#=>3

def median(arr)
  arr = arr.sort
  return nil if arr.empty?
  div = arr.length % 2
  if div == 1
    arr[(arr.length / 2)]
  else
    second = (arr.length / 2)
    first = second - 1
    (arr[first] + arr[second]) /2
  end
end

median([1,2,3,5,5,6])


def concats(arr)
  arr.inject("") do | ret_string, ele |
    ret_string += ele
  end
end

p concats(%w[a e i o u hello])
