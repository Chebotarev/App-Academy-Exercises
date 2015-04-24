def merge_sort(arr)
  #base case
  return arr if arr.length == 1 || arr.length == 0
  midpoint = arr.length / 2
  left, right = merge_sort(arr[0...midpoint]), merge_sort(arr[midpoint..-1])
  result = []
  until left.empty? || right.empty?
    case left[0] <=> right[0]
    when 1
      result << right.shift
    when 0
      result << right.shift
      result << left.shift
    when -1
      result << left.shift
    end
  end
  result += left + right
end


arr = [1, 9, 2, 8, 3, 7, 4, 6, 5]
p merge_sort(arr)
