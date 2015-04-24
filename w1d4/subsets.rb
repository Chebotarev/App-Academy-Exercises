load 'recursion.rb'
require 'byebug'

def subsets(arr)
  # debugger
  return [[]] if arr == []
  current_element = arr.first
  recurse = subsets(arr.drop(1))
  result = recurse + recurse.map { |x| x + [current_element] }

  result
end

p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]



my_arr = [[1]]

my_array.each do |el|

  el.push(4)
end
