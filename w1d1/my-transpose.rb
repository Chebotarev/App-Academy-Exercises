def my_transpose array
  transposed = []
  i = 0
  # while i < array.length
  #
  # end

  array.length.times do |iter|
    temp = []
    array.each do |arr|
      temp << arr[iter]
    end
    transposed << temp
  end

  transposed

end

p my_transpose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ])
