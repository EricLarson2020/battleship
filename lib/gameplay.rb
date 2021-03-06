require "pry"

class Gameplay
attr_reader :board_user, :board_computer, :cruiser, :computer, :player_cell_list
attr_accessor :cruiser_user, :submarine_user
#computer
  def initialize(board_user, board_computer, computer, player, cruiser_user, cruiser_computer, submarine_user, submarine_computer, multiboats = false)
    @board_user = board_user
    @board_computer = board_computer
    @computer = computer
    @cruiser_user = cruiser_user
    @submarine_user = submarine_user
    @cruiser_computer = cruiser_computer
    @submarine_computer = submarine_computer
    @player_cell_list = board_user.cells.keys
    @player = player
    @multiboats = multiboats
  end

  def run_multiboats
    if @multiboats
      @multiboats.ship_loop
      @cruiser_user = @multiboats.ships[0]
      @submarine_user = @multiboats.ships[1]
    end
  end


  def start
    var = welcome
    if var == true
      run_multiboats
      cruiser_and_submarine_assignment
      computer_placement
      play_loop
    end
  end

  def play_loop
    index = 0
    until game_over?
      player_shot
      if !game_over?
        computer_shot
      end
      index += 1
      #index is for pry access
    end
    win_or_lose_statement
  end

  def win_or_lose_statement
    if player_loss?
       p "Computer has won the game!"
    elsif computer_loss?
       p "Human has won the game!"
    end
  end

  def player_start
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    player_input = @player.player_starting_input
    until player_input == "p" || player_input == "q"
      p "Invalid input, please try again"
      player_input = @player.player_starting_input
    end
    player_input
  end

  def welcome_statement(player_input)

    if player_input == "p"
      p "I have laid out my ships on the grid."
      p "You now need to lay out your two ships."
      p "The Cruiser is three units long and the Submarine is two units long."
      p "  1 2 3 4"
      p "A . . . ."
      p "B . . . ."
      p "C . . . ."
      p "D . . . ."
      continue = true
    else
      p "Come back and play anytime!"
      continue = false
    end
    continue
  end

  def welcome
    player_input = player_start
    welcome_statement(player_input)
  end

  def cruiser_ship_input
    p "Enter the squares for the #{@cruiser_user.name} (#{@cruiser_user.length} spaces):"
  input = @player.ship_assignment
  input
  end

  def submarine_ship_input
    p "Enter the squares for the #{@submarine_user.name} (#{@submarine_user.length} spaces):"
    input = @player.ship_assignment
    input
  end

  def player_placement_valid(ship, input)
    if @board_user.valid_placement?(ship, input) != true
       until @board_user.valid_placement?(ship, input)
        p "Those are invalid coordinates. Please try again:"
        input = @player.ship_assignment
       end
    end
      @board_user.place(ship, input)
  end


  def cruiser_assignment(input_cruiser)
    ship = @cruiser_user
    # input = get_player_ship_input
    player_placement_valid(ship, input_cruiser)
    @board_user.render(true)
  end



  def submarine_assignment(input_submarine)

    ship = @submarine_user
    # input = get_player_ship_input
    player_placement_valid(ship, input_submarine)
    @board_user.render(true)
  end

  def cruiser_and_submarine_assignment
    input_cruiser = cruiser_ship_input
    cruiser_assignment(input_cruiser)
    input_submarine = submarine_ship_input if @submarine_user != nil
    submarine_assignment(input_submarine) if @submarine_user != nil
  end


  def computer_placement
    # binding.pry
    @board_computer.place(@cruiser_computer, @computer.auto_coordinates(@cruiser_computer))
    @board_computer.place(@submarine_computer, @computer.auto_coordinates(@submarine_computer))
    # require "pry";binding.pry
    puts "===========Computer Board==========="
    @board_computer.render(true)
    puts "===========PLAYER BOARD============="
    @board_user.render(true)
  end

  def player_cell_status(input)
    if input == "status"
      p "Enter exit to return to shot input"
      player_input = ""
        until player_input == "exit"
        p "Please enter a coordinate to check status, or exit to return."
        p player_input = @player.give_cell_status
        end
    end
  end


  def player_gives_shot_coordinate_or_checks_status
    p "Enter the coordinate for your shot, or type status to check cell status"
    input = @player.get_player_input
      player_cell_status(input)
    if input == "status"
      p "Enter the coordinates for your shot!"
      input = @player.get_player_input
    end
    input
  end

  def coordinates_are_validated(input)
    until @player_cell_list.include?(input)
      puts "Those are invalid coordinates. Please try again"
      input = @player.get_player_input
    end
    input
  end

  def player_shot_input
  input = player_gives_shot_coordinate_or_checks_status
  coordinates_are_validated(input)
  end

  def player_fire_on(cell_input)
    @player_cell_list.delete(cell_input)
    @board_computer.cells[cell_input].fire_upon
  end

  def status_board_computer(cell_input)
    @board_computer.cells[cell_input].render
    @board_computer.cells[cell_input].status
  end

  def player_call_result(cell_input)
    status_board_computer(cell_input)
    if status_board_computer(cell_input) == :missed
      p "Your shot on #{cell_input} was a miss."
    elsif status_board_computer(cell_input) == :hit
      p "Your shot on #{cell_input} was a hit!"
    elsif status_board_computer(cell_input) == :sunk
      p "You sunk computer's #{@board_computer.cells[cell_input].ship.name}!"
    end
  end

  def player_shot
    cell_input = player_shot_input
    player_fire_on(cell_input)
    player_call_result(cell_input)
  end



  def computer_picks_cell_and_fires_on_it
    input = @computer.smart_attack
    @board_user.cells[input].fire_upon
    input
  end

  def computer_hit_miss_or_sunk_statement(input)
    # require"pry";binding.pry
    if @board_user.cells[input].fired_upon? && @board_user.cells[input].ship == nil
      p "Computer's shot on #{input} was a miss."
    elsif @board_user.cells[input].ship.sunk?
        p "Computer sunk your #{@board_user.cells[input].ship.name}!"
    elsif @board_user.cells[input].fired_upon? && @board_user.cells[input].ship != nil
      p "Computer's shot on #{input} was a hit!"
    end
  end

  def board_render
    puts "===========Computer Board==========="
    @board_computer.render(true)
    puts "===========PLAYER BOARD============="
    @board_user.render(true)
  end

  def computer_shot
    input = computer_picks_cell_and_fires_on_it
    computer_hit_miss_or_sunk_statement(input)
    board_render
    input
  end



  def player_loss?
    if @cruiser_user.sunk? && ((@submarine_user.sunk? if @submarine_user != nil) || @submarine_user == nil)
      true
    else
      false
    end
  end

  def computer_loss?
    if @cruiser_computer.sunk? && @submarine_computer.sunk?
      true
    else
      false
    end
  end

  def game_over?
    if player_loss? || computer_loss?
      true
    else
      false
    end
  end

end # final
