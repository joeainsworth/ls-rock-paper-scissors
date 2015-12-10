# rps.rb

# Rock, Paper Scissors, Lizard, Spock

# paper   >   rock    & spock
# lizard  >   spock   & paper
# spock   >   scissor & rock
# rock    >   lizard  & scissor
# scissor >   lizard  & paper
# --------------------------

# require 'pry'
# require 'pry-byebug'

VALID_CHOICES = {
  'r'  => { name: 'rock',    beats:  %w(s l)  },
  'p'  => { name: 'paper',   beats:  %w(r sp) },
  's'  => { name: 'scissor', beats:  %w(p l)  },
  'l'  => { name: 'lizard',  beats:  %w(p sp) },
  'sp' => { name: 'spock',   beats:  %w(s r)  }
}

MESSAGE = {
  'r_s' =>  'crushes',
  'r_l' =>  'crushes',
  'p_r' =>  'covers',
  'p_sp' => 'disproves',
  's_p' =>  'cuts',
  's_l' =>  'decapitates',
  'l_p' =>  'eats',
  'l_sp' => 'poisons',
  'sp_s' => 'smashes',
  'sp_r' => 'vaporizes'
}

def prompt(message)
  puts("#{message}")
  print '=> '
end

def clear_screen
  system 'clear'
end

def divider
  '-' * 40
end

def valid_choices_ids
  VALID_CHOICES.keys
end

def choice_name(choice_key)
  VALID_CHOICES[choice_key][:name]
end

def beats(choice_key)
  VALID_CHOICES[choice_key][:beats]
end

def choices_menu
  valid_choices_ids.map { |id| "#{VALID_CHOICES[id][:name]} (#{id})" }.join(', ')
end

def players_choice
  choice = ''
  loop do
    prompt("Choose one: #{choices_menu}")
    choice = gets.chomp.downcase
    break if valid_choices_ids.include?(choice)
    puts 'That is not a valid selection'
  end

  choice
end

def message(winner, loser)
  message_key = "#{winner}_#{loser}" # 'r', 'l' => 'r_l'

  message = " #{choice_name(winner)} "
  message << "#{MESSAGE[message_key]} "
  message << "#{choice_name(loser)} "
end

def win?(first, second)
  beats(first).include?(second)
end

def finalize_game(player, computer, stats_hash)
  game_details = {
    player:         player,
    computer:       computer,
    winner:         '',
    loser:          '',
    draw:           false,
    player_message: ''
  }

  if win?(player, computer)
    stats_hash[:win] += 1
    game_details[:winner] = player
    game_details[:loser] = computer
    game_details[:player_message] = ' You win! '
  elsif win?(computer, player)
    stats_hash[:lose] += 1
    game_details[:winner] = computer
    game_details[:loser] = player
    game_details[:player_message] = ' You lose :<( '
  else
    stats_hash[:tie] += 1
    game_details[:draw] = true
    game_details[:player_message] = " It's a tie "
  end

  display_results(game_details, stats_hash)
end

def display_results(game_details, stats_hash)
  clear_screen

  game_message = message(game_details[:winner], game_details[:loser]).center(40, '/') unless game_details[:draw]

  results = <<-RESULTS
#{game_details[:player_message].center(40, '*')}
  You chose:       #{choice_name(game_details[:player])}
  Computer chose:  #{choice_name(game_details[:computer])}

#{game_message}

Game Stats ---
  Wins:         #{stats_hash[:win]}
  Losses:       #{stats_hash[:lose]}
  Draws:        #{stats_hash[:tie]}
  Total Games:  #{total_games(stats_hash)}
  Win Percent:  #{win_percentage(stats_hash)}%
#{divider}
  RESULTS

  puts results
end

def total_games(stats_hash)
  stats_hash.values.reduce(&:+)
end

def win_percentage(stats_hash)
  ((stats_hash[:win].to_f / total_games(stats_hash)) * 100).round(1)
end

# ------------- PROGRAM START ---------------------------

game_stats = { win: 0, lose: 0, tie: 0 }

loop do
  clear_screen

  choice = players_choice
  computer_choice = valid_choices_ids.sample
  finalize_game(choice, computer_choice, game_stats)

  prompt('Would you like to play again? (y/n)')
  break if gets.chomp.downcase == 'n'
end

puts 'Thanks for playing! Good bye.'
