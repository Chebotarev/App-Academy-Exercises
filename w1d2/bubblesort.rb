def bubble_sort(array)
  (0...array.length - 1).each do |n|
    (n + 1...array.length).each do |idx1|
      # idx2 = idx1 + 1
      value1, value2 = array[idx1], array[idx2]

      if value2 < value1
        array[idx1], array[idx2]  = value2, value1
      end
    end
  end

  array
end

# def bubble_sort(array)
#   sorted = false
#   until sorted
#     sorted = true
#     # iterate
#     # if we encounter unsorted elements
#       # flip them
#       # sorted = false
#     # end
#   end
# end
