Z_ORD = 'z'.ord

def ceasar_cipher(str, code)
  coded_string = ""

  str.each_char do |letter|
    num = letter.ord
    code %= 26
    num += code

    if num > Z_ORD
      num -= 26
    end

    coded_string << num.chr
  end
  coded_string
end

p ceasar_cipher("zany", 79)
