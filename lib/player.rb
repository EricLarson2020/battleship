class Player


#status player method

#starting_input_mehtod
  def player_starting_input
    starting_player_input = gets.chomp
    starting_player_input.downcase
    starting_player_input
  end

  def ship_assignment
    player_cruiser_assignment = gets.chomp
    modified_cruiser_assignment = player_cruiser_assignment.split(" ")
    modified_cruiser_assignment
  end

  def player_shot_input
    player_shot = gets.chomp
  end




  end
#method for ship assignment

#method for player firing
