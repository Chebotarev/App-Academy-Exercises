class Code
  COLORS = %w(r g b y o p)

  def initialize(string)
    @array = string.split(//)
    @peg_counts = Hash.new { |h, k| h[k] = 0 }
    @array.each { |el| @peg_counts[el] += 1 }
  end

  def self.random
    random_string = ""
    4.times do
      random_string << COLORS.sample
    end

    Code.new(random_string)
  end

  def self.parse(input)
    raise "InvalidInput" unless self.valid?(input)
    Code.new(input)
  end

  def exact_matches(other_code)
    matches = 0
    (1..4).each do |idx|
      matches += 1 if self.array[idx] == other_code.array[idx]
    end
    matches
  end

  def near_matches(other_code)
    matches = 0
    @peg_counts.each do |color_code, number1|
      number2 = other_code.peg_counts[color_code]
      matches += [number1, number2].min
    end
    matches
  end

  protected
    attr_accessor :array
    attr_accessor :peg_counts

    def self.valid?(string)
      return false unless string.length == 4
      string.split(//).each do |letter|
        return false unless COLORS.include?(letter)
      end
      true
    end

end

class Game
  def run
    secret = Code.random
    guesses = play(secret)
    if guesses < 9
      puts "You won! You guessed #{guesses} times."
    else
      puts "You lost :("
    end
    "END"
  end


  private

  def play(secret)
    guesses = 0

    while guesses < 10
      guess = prompt_user
      break if won?(guess, secret)
      display_failure(guess, secret)
      guesses += 1
    end

    guesses
  end

  def prompt_user
    puts "Enter your guess"
    guess = gets.chomp
    Code.parse(guess)
  end

  def won?(guess, secret)
    guess.exact_matches(secret) == 4
  end

  def display_failure(guess, secret)
    puts "Number of exact matchs: #{guess.exact_matches(secret)}"
    puts "Number of near matchs: #{guess.near_matches(secret)}"
  end
end

c = Game.new
c.run
