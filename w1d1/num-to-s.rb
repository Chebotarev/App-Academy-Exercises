#better way?
NUMBERS = {
  0 => "0",
  1 => "1",
  2 => "2",
  3 => "3",
  4 => "4",
  5 =>"5",
  6 =>"6",
  7 =>"7",
  8 =>"8",
  9 =>"9",
  10 => "A",
  11 => "B",
  12 => "C",
  13 => "D",
  14 => "E",
  15 => "F",
}

def num_to_s(num, base)
  ret_string = ""
  n = 0
  base_multiplied = base ** n

  until base_multiplied > num
    digit = ((num / base_multiplied) % base)
    ret_string << NUMBERS[digit]
    n += 1
    base_multiplied = base ** n
  end
  ret_string.reverse
end

p num_to_s(234, 2)
p num_to_s(43534, 2)
p num_to_s(23453453454, 2)
