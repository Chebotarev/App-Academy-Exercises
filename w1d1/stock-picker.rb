def stock_picker array
  answer = nil
  i = 0
  max_profit = 0
  while i < array.length
    j = i + 1
    while j < array.length
      profit = array[j] - array[i]
      if profit > max_profit
        max_profit = profit
        answer = [i,j]
      end
      j += 1
    end
    i += 1
  end
  answer
end


p stock_picker([4,3,2,5,4,3,9,5])



# array.each_index do |i|
#   (i+1...array.length).each do |j|
#
#   end
# end
