require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/computer'
require "pry"
class Gameplay
attr_reader :board1, :cruiser
  def initialize(board1, board2, computer = nil)
    @board1 = board1
    @board2 = board2
    @computer = computer
    @cruiser1 = Ship.new("Cruiser", 3)
    @submarine1 = Ship.new("Submarine", 2)
    @cruiser2 = Ship.new("Cruiser", 3)
    @submarine2 = Ship.new("Submarine", 2)
    @player_cell_list = board1.cells.keys
  end

  def start
    welcome
    cruiser_assignment
    submarine_assignment
    computer_placement
  end

  def play_loop
    # binding.pry
    index = 0
    until game_over?
      player_shot
      computer_shot
      index += 1
      # if index >= 1
      #      binding.pry
      # end
    end
    if @player1_sunk
      p "Computer has won the game!"
    elsif @player2_sunk
      p "Human has won the game!"
    end



  end

  def welcome
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."

    input = gets.chomp
    if input.downcase == "p"



      p "I have laid out my ships on the grid."
      p "You now need to lay out your two ships."
      p "The Cruiser is three units long and the Submarine is two units long."
      p "  1 2 3 4"
      p "A . . . ."
      p "B . . . ."
      p "C . . . ."
      p "D . . . ."
    end
  end


  def cruiser_assignment
    p "Enter the squares for the Cruiser (3 spaces):"
    input_2 = gets.chomp
    input_2 = input_2.split(" ")

    if @board1.valid_placement?(@cruiser1, input_2) != true
       until @board1.valid_placement?(@cruiser1, input_2)
        p "Those are invalid coordinates. Please try again:"
        input_2 = gets.chomp
        input_2 = input_2.split(" ")
      end
    end
    @board1.place(@cruiser1, input_2)
    @board1.render(true)
  end

  def submarine_assignment
    p "Enter the squares for the Submarine (2 spaces):"
    input_3 = gets.chomp
    input_3 = input_3.split(" ")
    if @board1.valid_placement?(@submarine1, input_3) != true
       until @board1.valid_placement?(@submarine1, input_3)
        p "Those are invalid coordinates. Please try again:"
        input_3 = gets.chomp
        input_3 = input_3.split(" ")
      end
    end
    @board1.place(@submarine1, input_3)
    @board1.render(true)
  end

  def computer_placement
    #binding.pry
    @board2.place(@cruiser2, @computer.auto_coordinates(@cruiser2))
    @board2.place(@submarine2, @computer.auto_coordinates(@submarine2))
    puts "===========Computer Board==========="
    @board2.render(true)
    puts "===========PLAYER BOARD============="
    @board1.render(true)
  end

  def player_shot
    p "Enter the coordinate for your shot"
    input = gets.chomp
    until @player_cell_list.include?(input)
      puts "Those are invalid coordinates. Please try again"
      input = gets.chomp
      if input == "pry"
        binding.pry
      end
    end
    #delete player input from avaliable cell list
    index = @player_cell_list.index(input)
    @player_cell_list.delete_at(index)

    #call result
    @board2.cells[input].fire_upon
    if @board2.cells[input].fired_upon? && @board2.cells[input].ship == nil
      p "Your shot on #{input} was a miss."
    elsif @board2.cells[input].fired_upon? && @board2.cells[input].ship != nil
      p "Your shot on #{input} was a hit!"
      if @board2.cells[input].ship.sunk?
        p "You sunk computer's #{@board2.cells[input].ship.name}!"
      end
    end
    puts "===========Computer Board==========="
    @board2.render(true)
    puts "===========PLAYER BOARD============="
    @board1.render(true)

  end

  def computer_shot
    input = @computer.attack
    @board1.cells[input].fire_upon
    @board1.cells[input].fire_upon
    if @board1.cells[input].fired_upon? && @board1.cells[input].ship == nil
      p "Computer's shot on #{input} was a miss."
    elsif @board1.cells[input].fired_upon? && @board1.cells[input].ship != nil
      p "Computer's shot on #{input} was a hit!"
      if @board1.cells[input].ship.sunk?
        p "Computer sunk your #{@board1.cells[input].ship.name}!"
      end
    end
    # puts "===========Computer Board==========="
    # @board2.render(true)
    # puts "===========PLAYER BOARD============="
    # @board1.render(true)
  end

  def game_over?

    ship_list_player = @board1.cells.find_all do |cell|
      cell[1].ship != nil
    end
    ship_list_computer = @board2.cells.find_all do |cell|
      cell[1].ship != nil
    end

    if ship_list_player != []
      @player1_sunk = ship_list_player.all? do |cell|
        cell[1].ship.sunk?
      end
    else
      @player1_sunk = false
    end

    if ship_list_computer != []
      @player2_sunk = ship_list_computer.all? do |cell|
        cell[1].ship.sunk?
      end
    else
    @player2_sunk = false
    end
    # if @player1_sunk || @player2_sunk
    #   binding.pry
    # end
    @player1_sunk || @player2_sunk
  end


end # final
