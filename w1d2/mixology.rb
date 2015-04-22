def remix(combos)
  alcohols = []
  # alcohols = combos.map(&:first)
  mixers = []

  combos.each do |combo|
    alcohols << combo[0]
    mixers << combo[1]
  end

  mix alcohols, mixers
end

def mix(alcohols, mixers)
  mixed = mixers
  results = []
  until mixed != mixers
    mixed = mixers.shuffle
  end

  (0...alcohols.count).each do |idx|
    results << [alcohols[idx], mixed[idx]]
  end

  # until results.none? { |result| combos.include?(result) }

  results
end

p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
])
