def guessing_game
  answer = rand(1..100)
  number_of_guesses = 0
  guess = nil

  loop do
    print "Guess a number: "
    guess = Integer(gets)
    # guess = gets.chomp.to_i
    number_of_guesses += 1

    guess == answer ? break : check(guess, answer)
  end

  "You win! You guessed: #{number_of_guesses} times"
end

def check(guess, answer)
  if guess < answer
    puts " Too low"
  else
    puts " Too high"
  end
end
