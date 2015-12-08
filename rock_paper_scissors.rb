# Ask user what their choice is
# Validate choice
# Computer selects choice at random
# Compare choices and show result

VALID_CHOICES = %w(rock paper scissors)

def prompt(msg)
  Kernel.puts("=> #{msg}")
end

def display_result(player_choice, computer_choice)
    if player_choice == 'rock' && computer_choice == 'scissors' ||
        player_choice == 'paper' && computer_choice == 'rock' ||
        player_choice == 'scissors' && computer_choice == 'paper'
        'Player won!'
    elsif computer_choice == 'rock' && player_choice == 'scissors' ||
          computer_choice == 'paper' && player_choice == 'rock' ||
          computer_choice == 'scissors' && player_choice == 'paper'
          'Computer won!'
    else
      "It's a tie!"
    end
end

prompt('Welcome to Rock, Paper Scissors!')

loop do
  player_choice = ''
  prompt("Please make your selection from #{VALID_CHOICES.join(", ")}")
  loop do
    player_choice = Kernel.gets().chomp()
    if VALID_CHOICES.include?(player_choice.downcase)
      break
    else
      prompt("Please enter a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("Player chose #{player_choice} and the computer chose #{computer_choice}")

  prompt(display_result(player_choice, computer_choice))

  prompt('Would you like to play again? [y] yes [n] no')
  play_again = Kernel.gets().chomp()
  break unless play_again.downcase.start_with?('y')
end
