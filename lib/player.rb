class Player
  attr_reader :board_user, :board_computer
  def initialize (board_user, board_computer)
    @board_user = board_user
    @board_computer = board_computer
  end

  def player_starting_input
    starting_player_input = gets.chomp
    starting_player_input = starting_player_input.downcase
    starting_player_input
  end

  def ship_assignment
    player_cruiser_assignment = gets.chomp
    modified_cruiser_assignment = player_cruiser_assignment.split(" ")
    modified_cruiser_assignment
  end

  def get_player_input
    player_shot = gets.chomp
  end

  def get_cell
    cell = gets.chomp
    cell.to_s
  end

  def cell_status(cell)
    board_user.render
      if cell != "exit" && board_user.valid_coordinate?(cell)
        # require"pry";binding.pry
        board_user.cells[cell].status
    else
     p "exit"
   end
  end
#Can't test takes player input
  def give_cell_status
    cell = get_cell
    cell_status(cell)
  end

  end


#   def cell_status
#   cell = player.gets.chomp
#   cell.to_s
#   board_user.render
#   board_user.cells[cell].status
#
# end

#method for ship assignment

#method for player firing
