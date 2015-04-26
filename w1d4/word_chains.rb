require 'set'

class WordChainer
  def initialize(dictionary_file_name)
    print "Loading dictionary..."
    @dictionary = Set.new File.readlines(dictionary_file_name).map(&:chomp)
    print "done\n"
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }

    print "Exploring possible words..."
    until @all_seen_words.has_key?(target) || @current_words.empty?
      explore_current_words
    end
    print "done\n"

    print "Trying to build path..."
    path = build_path(target)
    print "done\n"

    if path != [target] then puts path else puts "No path found!" end
  end

  private

    def adjacent_words(word)
      adjacent_words = []

      letters = ('a'..'z').to_a

      word.each_char.with_index do |prev_char, idx|
        letters.each do |next_char|
          next if prev_char == next_char
          new_word = word[0...idx] + next_char + word[idx + 1...word.length]
          adjacent_words << new_word if @dictionary.include?(new_word)
        end
      end

      adjacent_words
    end

    def build_path(target)
      path = []
      previous = @all_seen_words[target]

      until previous.nil?
        path << previous
        previous = @all_seen_words[previous]
      end

      path.unshift(target)
      path.reverse
    end

    def explore_current_words
      new_current_words = []

      @current_words.each do |current_word|
        adjacent_words(current_word).each do |adjacent_word|
          next if @all_seen_words.has_key?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
        end
      end

      @current_words = new_current_words
    end

end

if __FILE__ == $PROGRAM_NAME
  chainer = WordChainer.new("dictionary.txt")
  chainer.run("testing", "forests
  ")
end
