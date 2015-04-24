# First, do the traditional American money thing: take as many of
# the biggest coin as you can. Then do a recursion on the remaining
# amount, leaving out the biggest kind of coin.
require 'byebug'

# def make_change(amount, coins = [25, 10, 5, 1])
#   p coins
#   return [] if coins.empty?  amount == 0
#   while amount < coins[0]
#     coins = coins[1..-1]
#   end
#   nested_results = []
#   (0...coins.length).each do |i|
#     coin = coins[i]
#     coins = coins[i..-1]
#     result = []
#     result << coin
#     amount -= coin
#     result += make_change(amount, coins)
#     nested_results << result
#   end
#   nested_results.max_by { |x| x.length }
# end

# def make_change()
#
# end

def make_change(amount, coins = [25, 10, 5, 1])
  return [] if coins.nil? || coins.empty? || amount == 0
  while amount < coins[0]
    coins = coins[1..-1]
  end
  result = []
  coin = coins[0]
  result << coin
  amount -= coin
  result += make_change(amount, coins)
end


def new_make(amount, coins = [25, 10, 5, 1])
  results = []
  coins.each_index do |idx|
    coins = coins[idx..-1]
    unless make_change(amount, coins).empty?
      results << make_change(amount, coins)
    end
  end

  p results
  results.min_by { |result| result.length }
end

p new_make(20)
p new_make(14, [10, 7, 1])
