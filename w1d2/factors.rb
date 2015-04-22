def factors(num)
  results = [1]
  (2..num).each do |factor|
    results << factor if num % factor == 0
  end

  results
end
