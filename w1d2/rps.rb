CHOICES = [ 'rock', 'paper', 'scissors']

OUTCOMES = {
  ['rock', 'paper'] => "Lose",
  ['rock', 'scissors'] => "Win",
  ['rock', 'rock'] => "Draw",

  ['paper', 'paper'] => "Draw",
  ['paper', 'scissors'] => "Lose",
  ['paper', 'rock'] => "Win",

  ['scissors', 'paper'] => "Win",
  ['scissors', 'scissors'] => "Draw",
  ['scissors', 'rock'] => "Lose"
}


def rps(user_choice)
  computer_choice = CHOICES.sample
  # computer_choice_index = Random.new.rand(0..2)
  # computer_choice = CHOICES[computer_choice_index]

  "#{computer_choice}, #{OUTCOMES[[user_choice, computer_choice]]}"
end

p rps("scissors")
