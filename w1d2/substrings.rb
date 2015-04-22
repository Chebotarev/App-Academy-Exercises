def substrings(string)
  substrings = []

  (0...string.length).each do |start_letter|
    (start_letter...string.length).each do |end_letter|
      substrings << string[start_letter..end_letter]
    end
  end

  substrings
end

def subwords(string)
  substrings = substrings(string)
  dictionary_words = File.readlines('dictionary.txt')
  dictionary_words.map!(&:chomp)
  dictionary_hash = {}
  dictionary_words.each { |word| dictionary_hash[word] = true }
  substrings.select { |sub| dictionary_hash.has_key?(sub) }
  #
  # substrings.each do |substring|
  #     #words << substring if dictionary.grep(/#{substring}/)
  #   words << substring if dictionary_words.include?(substring)
  # end
  #
  # words
end
