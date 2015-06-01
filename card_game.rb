def stars
  puts "**************************************"
end

def insert_line
  puts "\n"
end
# Methods to enhance UX & reduce code redundancy

suits = ["hearts", "spades", "diamonds", "clubs"]
card_values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

deck_o_cards = []
# Initialize array to hold "deck" of cards once theyre created

suits.each do |suit|
    card_values.each_with_index do |value, index|
        card = Hash.new
        card[:suit] = suit
        card[:card_value] = value
        card[:index] = index
        deck_o_cards.push(card)
        # Creates cards by merging card values & suits
        # and assigns index num for card value comparisons in game
        # and adds each card to "deck" array
    end
end

player_name_array = []
# Initialize array to hold player names input by user

current_game = []
# Initilize array to represent current "game"
# holds hashes--one for each player name & their given card

deck_o_cards.shuffle!
# Shuffles deck

##### DEBUG #####
#deck_o_cards.each { |card| puts "#{card}\n" }
## Displays shuffled list of cards
#puts "Number of cards: #{deck_o_cards.count.to_i}"
#puts "Number of players: #{player_name_array.count.to_i}"
## Checking initial values to ensure correct
##### DEBUG #####


i = 0
while i < 2
    puts "Please enter a player name and press enter:"
    player = gets.chomp.to_s
    player_name_array.push(player)
    i+=1
end
  # Force user to enter at least two players
  # Add each name to array of players
i = 2
# have to define i outside of "while true" to make it update per below +=
while true
  # to allow use of "break"
if i < deck_o_cards.count.to_i
    puts "#{player_name_array.count.to_i} players so far. Enter another player name, or type 'play':"
    player = gets.chomp.to_s
      if player.downcase == "play"
        break
      else
        player_name_array.push(player)
        i+=1
      end
    # Give option of selecting play or adding an additional player
    # Allow as many players as there are cards in deck
  else
    puts "There are now #{player_name_array.count.to_i} players, and there are only #{deck_o_cards.count.to_i} cards in the deck!"
    puts "So no additional players may be added."
    puts "Please type 'play' and press Enter to begin game!"
    # Tells user they've entered as many players as there are cards
    # Prompts user to start game
    player = gets.chomp.to_s
      if player.downcase == "play"
        break
      else
        break
      end
      # Starts game regardless of what user enters (might as well)
  end
end
# Ensure user can't enter more players than there are cards


puts "**************************************"
puts "            STARTING GAME"
puts "**************************************"
puts "***  Total number of players is #{player_name_array.count.to_i}  ***"
stars
# For UX
insert_line

i = 0
while i < player_name_array.count.to_i
    player_card = Hash.new
    player_card[:playername] = player_name_array[i]
    player_card[:card] = deck_o_cards.pop
    # Pops card off deck & "gives" to player
    current_game.push(player_card)
    # Inserts hash w/ player's name & card into array created to represent current game
    puts "#{player_card[:playername]} was dealt the #{player_card[:card][:card_value]} of #{player_card[:card][:suit]}"###DEBUG###
    # Displays each player's name and card dealt
    # Nature of game requires zero secrecy
    i+=1
end
insert_line

stars
puts "***  Cards remaining in deck: #{deck_o_cards.count}  ***"###DEBUG###
# UX & to ensure program running correctly!
stars


### THIS SECTION IS JUST TO EASILY ENSURE GAME FUNCTIONING CORRECTLY ###
sorted_list = current_game.sort_by { |hsh| hsh[:card][:index] }###DEBUG###
#OKAY: so this ^ sorts reliably based on index number, smallest to largest
puts "Sorted List of Players by their Hands:"###DEBUG###
insert_line
sorted_list.each { |a| puts "#{a[:playername]} has the #{a[:card][:card_value]} of #{a[:card][:suit]} with a rank of #{a[:card][:index]}\n" }###DEBUG###
# How to make ^ two lines since long line of code??
# Displays list of players & their cards from lowest to highest ranked
# To make easy to determine program working
### END OF SECTION FOR DEBUGGING ###


## Okay I'm going to rig this to work (HOW SHOULD DO--FEELS VERY RIGGED):

high_card = current_game.max_by { |hsh| hsh[:card][:index].to_i }
# ^ Was NOT working correctly without .to_i (how do I determine what it *was* doing?)
# Selects max card (don't know how to select more than one)
winners = current_game.select { |card| card[:card][:index] == high_card[:card][:index] }
# Creates array containing all winners in case of tie
insert_line
winners.each { |high_card| puts "The high card is #{high_card[:playername]}'s #{high_card[:card][:card_value]} of #{high_card[:card][:suit]}\n" }###DEBUG###
# Displays list of all winning players and their cards for user (& mainly debugging)
puts "The high card index number is #{high_card[:card][:index]}"###DEBUG###
# Displays highest card index number
stars
stars

if winners.count == 1
  puts "***** The winner is #{winners[0][:playername]} *****"
else
  print "It's a tie between #{winners[0][:playername]}"
  i = 1
  while i < winners.count.to_i
    print " and #{winners[i][:playername]}"
    i+=1
  end
  # Displays winner(s) to screen
  # Didn't know shorter way than ^ to account for diff language needed
  print "!"
  puts "\n"
end
stars
stars
puts "           GAME COMPLETED!"
stars
