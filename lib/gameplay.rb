require "pry"

class Gameplay
attr_reader :board_user, :board_computer, :cruiser
#computer
  def initialize(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
    @board_user = board_user
    @board_computer = board_computer
    @computer = computer
    @cruiser1 = cruiser1
    @submarine1 = submarine1
    @cruiser2 = cruiser2
    @submarine2 = submarine2
    @player_cell_list = board_user.cells.keys
    @player = player
  end

  def start

    var = welcome
    if var == true
      cruiser_assignment
      submarine_assignment
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
    until player_input == "p" || "q"
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
  #
  # def welcome
  #   input = ''
  #   until input.downcase == 'p' || input.downcase == 'q'
  #     p "Welcome to BATTLESHIP"
  #     p "Enter p to play. Enter q to quit."
  #     input = gets.chomp
  #     if input.downcase == "p"
  #       @play_game = true
  #     elsif input.downcase == 'q'
  #       @play_game = false
  #       "Come back and play anytime!"
  #       return
  #     else
  #       p "Invalid entry"
  #     end
  #   end
  #
  #   if @play_game
  #     p "I have laid out my ships on the grid."
  #     p "You now need to lay out your two ships."
  #     p "The Cruiser is three units long and the Submarine is two units long."
  #     p "  1 2 3 4"
  #     p "A . . . ."
  #     p "B . . . ."
  #     p "C . . . ."
  #     p "D . . . ."
  #   end
  #
  # end
def play_placement_valid

end

  def cruiser_assignment
    p "Enter the squares for the Cruiser (3 spaces):"
    input_2 = @player.cruiser_assignment
    if @board_user.valid_placement?(@cruiser1, input_2) != true
       until @board_user.valid_placement?(@cruiser1, input_2)
        p "Those are invalid coordinates. Please try again:"
        @player.cruiser_assignment
       end
    end
    @board_user.place(@cruiser1, input_2)
    @board_user.render(true)
  end

  def submarine_assignment
    p "Enter the squares for the Submarine (2 spaces):"
    input_3 = gets.chomp
    input_3 = input_3.split(" ")
    if @board_user.valid_placement?(@submarine1, input_3) != true
       until @board_user.valid_placement?(@submarine1, input_3)
        p "Those are invalid coordinates. Please try again:"
        input_3 = gets.chomp
        input_3 = input_3.split(" ")
       end
    end
    @board_user.place(@submarine1, input_3)
    @board_user.render(true)
  end

  def computer_placement
    # binding.pry
    @board_computer.place(@cruiser2, @computer.auto_coordinates(@cruiser2))
    @board_computer.place(@submarine2, @computer.auto_coordinates(@submarine2))
    puts "===========Computer Board==========="
    @board_computer.render(true)
    puts "===========PLAYER BOARD============="
    @board_user.render(true)
  end

  def player_shot_input
    p "Enter the coordinate for your shot"
    input = gets.chomp
    until @player_cell_list.include?(input)
      puts "Those are invalid coordinates. Please try again"
      input = gets.chomp
    end
    input
  end

  def player_fire_on(cell_input)
    @player_cell_list.delete(cell_input)
    @board_computer.cells[cell_input].fire_upon
  end

  def status_board_computer(cell_input)
    # binding.pry
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


######### ORIGINAL #############
  # def player_shot
  #   p "Enter the coordinate for your shot"
  #   input = gets.chomp
  #   until @player_cell_list.include?(input)
  #     puts "Those are invalid coordinates. Please try again"
  #     input = gets.chomp
  #   end
  #   # delete player input from avaliable cell list
  #   index = @player_cell_list.index(input)
  #   @player_cell_list.delete_at(index)
  #
  #   #call result
  #   @board_computer.cells[input].fire_upon
  #   if @board_computer.cells[input].fired_upon? && @board_computer.cells[input].ship == nil
  #     p "Your shot on #{input} was a miss."
  #   elsif @board_computer.cells[input].fired_upon? && @board_computer.cells[input].ship != nil
  #     p "Your shot on #{input} was a hit!"
  #     if @board_computer.cells[input].ship.sunk?
  #       p "You sunk computer's #{@board_computer.cells[input].ship.name}!"
  #     end
  #   end


  # end

  def computer_shot
    input = @computer.smart_attack
    @board_user.cells[input].fire_upon
    if @board_user.cells[input].fired_upon? && @board_user.cells[input].ship == nil
      p "Computer's shot on #{input} was a miss."
    elsif @board_user.cells[input].fired_upon? && @board_user.cells[input].ship != nil
      p "Computer's shot on #{input} was a hit!"
      if @board_user.cells[input].ship.sunk?
      #  binding.pry
        p "Computer sunk your #{@board_user.cells[input].ship.name}!"
      end
    end
    puts "===========Computer Board==========="
    @board_computer.render(true)
    puts "===========PLAYER BOARD============="
    @board_user.render(true)
  end

  def player_loss?
    if @cruiser1.sunk? && @submarine1.sunk?
      true
    else
      false
    end
  end

  def computer_loss?
    if @cruiser2.sunk? && @submarine2.sunk?
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
