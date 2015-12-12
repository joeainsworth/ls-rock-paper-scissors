require 'pry'

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

def calculate_result(player_choice, computer_choice)
  if win?(player_choice, computer_choice)
    'player'
  elsif win?(computer_choice, player_choice)
    'computer'
  else
    'tie'
  end
end

def options
  VALID_CHOICES.keys.map { |key| "[#{key}] #{VALID_CHOICES[key][:name]}" }
end

def option_name(option_key)
  VALID_CHOICES[option_key][:name].downcase
end

def computers_turn
  VALID_CHOICES.keys.sample
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

def display_round(player_choice, computer_choice)
  "Player chose #{player_choice} and the computer chose #{computer_choice}"
end

def display_score(player_score, computer_score)
  "Score; [#{player_score}] Player [#{computer_score}] Computer "
end

def display_outcome(player_score, computer_score)
  player_score > computer_score ? 'Player won!' : 'Computer won!'
end

def play_again
  prompt('Would you like to play again? [y] yes [n] no')
  Kernel.gets().chomp()
end

system 'clear'

player_score = 0
computer_score = 0

prompt('Welcome to Rock, Paper, Scissors, Spock, Lizard!')

loop do
  player_choice = players_turn
  computer_choice = computers_turn

  prompt(display_round(option_name(player_choice), option_name(computer_choice)))

  case calculate_result(player_choice, computer_choice)
  when 'player'
    player_score += 1
    prompt('Player wins!')
  when 'computer'
    computer_score += 1
    prompt('Computer wins!')
  when 'tie'
    prompt("It's a tie!")
  end

  prompt(display_score(player_score, computer_score))

  break if player_score == 5 ||
           computer_score == 5 ||
           !play_again.downcase.start_with?('y')

  system 'clear'
end

prompt(display_outcome(player_score, computer_score))
