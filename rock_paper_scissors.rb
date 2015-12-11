VALID_CHOICES = {
  's' => { name: 'Scissors', beats: %w(p l) },
  'p' => { name: 'Paper', beats: %w(r sp) },
  'r' => { name: 'Rock', beats: %w(l s) },
  'l' => { name: 'Lizard', beats: %w(sp p) },
  'sp' => { name: 'Spock', beats: %w(s r) }
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

def options
  VALID_CHOICES.keys.map do |key|
    "(#{key}) #{VALID_CHOICES[key][:name]}"
  end
end

def option_name(option_key)
  VALID_CHOICES[option_key][:name].downcase
end

def players_turn
  prompt("Please make your selection from #{options.join(', ').downcase}")

  loop do
    player_choice = Kernel.gets().chomp()
    if VALID_CHOICES.keys.include?(player_choice.downcase)
      return player_choice
    else
      prompt("Please enter a valid choice.")
    end
  end
end

prompt('Welcome to Rock, Paper Scissors!')

loop do
  player_choice = ''

  prompt("Please make your selection from #{options.join(', ').downcase}")
  loop do
    player_choice = Kernel.gets().chomp()
    if VALID_CHOICES.keys.include?(player_choice.downcase)
      break
    else
      prompt("Please enter a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.keys.sample

  output = "Player chose #{option_name(player_choice)} and the computer " +
           "chose #{option_name(computer_choice)}"
  prompt(output)
  prompt(display_result(player_choice, computer_choice))

  prompt('Would you like to play again? [y] yes [n] no')
  play_again = Kernel.gets().chomp()
  break unless play_again.downcase.start_with?('y')
end
