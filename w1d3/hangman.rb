class HumanPlayer
  def guess(state)
    puts "Secret word: #{state.join}"
    print "> "
    gets.chomp
  end

  def pick_secret_word
    puts "Enter the length of your word."
    Integer(gets.chomp)
  end

  def handle_guess_response(guess)
    check_guess(guess)
  end

  def receive_secret_length(length)
    puts "The word has #{length} letters"
  end

  private

  def check_guess(guess)
    puts "Enter the positions '#{guess}' appears in your word (Enter for none)"
    gets.chomp.split.map(&:to_i)
  end
end

class ComputerPlayer
  def initialize
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @guessed = []
  end

  def pick_secret_word
    self.secret_word = @dictionary.sample
    secret_word.length
  end

  def guess(state)
    update_dictionary(state)
    p @dictionary.length
    guess = most_frequent_letter(state)
    @guessed << guess
    guess
  end

  def handle_guess_response(guess)
    check_guess(guess)
  end

  def receive_secret_length(number)
    @dictionary.select! { |word| word.length == number }
  end

  private

    def check_guess(guess)
      matched_indices = []
      secret_word.split("").each_with_index do |char, idx|
        matched_indices << idx if char == guess
      end
      matched_indices
    end

    def update_dictionary(state)
      state.each_with_index do |letter, index|
        next if letter == "_"
        @dictionary.reject! { |word| word[index] != letter }
      end
    end

    def most_frequent_letter(state)
      letter_frequencies = Hash.new(0)
      @dictionary.each do |word|
        word.each_char do |letter|
          next if @guessed.include?(letter)
          letter_frequencies[letter] += 1
        end
      end

      letter_frequencies.sort_by { |k, v| v }.last[0]
    end

    private

    attr_accessor :secret_word
end
#
# class Player
#
#   def initialize
#   end
#
#   def check_guess(guess)
#     matched_indices = []
#     secret_word.split("").each_with_index do |char, idx|
#       matched_indices << idx if char == guess
#     end
#     matched_indices
#   end
# end

class Hangman
  attr_accessor :state

  def initialize(guessing_player, secret_player)
    @guessing_player = guessing_player
    @secret_player = secret_player
    @state = Array.new(@secret_player.pick_secret_word) { '_' }
  end

  def run
    @guessing_player.receive_secret_length(@state.length)
    while @state.include?('_')
      guess = @guessing_player.guess(@state)
      if @state.include?(guess)
        puts "You've already guessed that!"
        next
      end
      update_state(guess)
    end
    puts "You won! The word was #{@state.join}"
  end

  private

  def update_state(guess)
    response = @secret_player.handle_guess_response(guess)
    response.each do |idx|
      @state[idx] = guess
    end
  end
end

# hang = Hangman.new(HumanPlayer.new, ComputerPlayer.new)
hang = Hangman.new(ComputerPlayer.new, HumanPlayer.new)
hang.run
