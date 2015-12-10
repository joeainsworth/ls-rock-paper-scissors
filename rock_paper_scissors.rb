VALID_CHOICES = {
  'scissors' => { beats: %w(paper lizard) },
  'paper' => { beats: %w(rock spock) },
  'rock' => { beats: %w(lizard scissors) },
  'lizard' => { beats: %w(spock paper) },
  'spock' => { beats: %w(scissors rock) }
}

def prompt(msg)
  Kernel.puts("=> #{msg}")
end

def win?(first, second)
  VALID_CHOICES[first][:beats].include?(second)
end

def display_result(player_choice, computer_choice)
  if win?(player_choice, computer_choice)
    'Player won!'
  elsif win?(computer_choice, player_choice)
    'Computer won!'
  else
    "It's a tie!"
  end
end

def players_turn
  prompt("Please make your selection from #{VALID_CHOICES.keys.join(', ')}")

  loop do
    player_choice = Kernel.gets().chomp()
    if VALID_CHOICES.keys.include?(player_choice.downcase)
      return player_choice
    else
      prompt("Please enter a valid choice.")
    end
  end
end

def play_game
  player_choice = players_turn
  computer_choice = VALID_CHOICES.keys.sample
  prompt("Player chose #{player_choice} and the computer chose #{computer_choice}")
  prompt(display_result(player_choice, computer_choice))
end

prompt('Welcome to Rock, Paper Scissors!')

loop do
  play_game
  prompt('Would you like to play again? [y] yes [n] no')
  play_again = Kernel.gets().chomp()
  break unless play_again.downcase.start_with?('y')
end
