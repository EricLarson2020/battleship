class Player
attr_reader :board_user, :board_computer
def initialize (board_user, board_computer)
@board_user = board_user
@board_computer = board_computer
end
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

  def cell_status
    cell = player.gets.chomp
    cell.to_s
    board_user.render
    board_user.cells[cell].status

  end




  end
#method for ship assignment

#method for player firing
