require './lib/board'
require './lib/cell'
require './lib/ship'
require "pry"
class Gameplay
attr_reader :board1, :board2, :cruiser, :computer
  def initialize(board1, board2, computer)
    @board1 = board1
    @board2 = board2
    @cruiser1 = Ship.new("Cruiser", 3)
    @submarine1 = Ship.new("Submarine", 2)
    @computer = Computer.new(board2)
    @cruiser2 = Ship.new("Cruiser", 3)
    @submarine2 = Ship.new("Submarine", 2)
  end



  def welcome
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."

    input = gets.chomp
    until input.downcase == "p" || input.downcase == "q"
      p "Invalid input, please try again"
      input = gets.chomp
    end
    if input == "q"
      @welcome= false
       return

    p "I'm sorry that you don't want to play"


    else
      p "I have laid out my ships on the grid."
      p "You now need to lay out your two ships."
      p "The Cruiser is three units long and the Submarine is two units long."
      p "  1 2 3 4"
      p "A . . . ."
      p "B . . . ."
      p "C . . . ."
      p "D . . . ."
      @welcome = true
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

  def computer_assignment
    cruiser_auto_place = computer.auto_coordinates(@cruiser2)
    submarine_auto_place = computer.auto_coordinates(@submarine2)
    @board2.place(@cruiser2, cruiser_auto_place)
    @board2.place(@submarine2, submarine_auto_place)
    @board2.render(true)
  end

  def display_the_board
    p "=============COMPUTER BOARD============="
    @board2.render(true)
    p "==============PLAYER BOARD=============="
    @board1.render(true)
  end

  def fire
    p "Enter the coordinate for your shot:"
    input = gets.chomp
    input.to_s
    letters = ["A", "B", "C", "D"]
    numbers = ["1", "2", "3", "4"]

    # until @player_cell_list.include?(input)
    #       puts "Those are invalid coordinates. Please try again"
    #       input = gets.chomp
    #     end

    until letters.include?(input[0]) && numbers.include?(input[1])  
      p "Please enter a valid coordinate:"
      input = gets.chomp
      input.to_s
    end
    @board2.cells[input].fire_upon

        if @board2.cells[input].ship == nil
          p "My shot on #{input} was a miss"
        elsif @board2.cells[input].ship != nil && @board2.cells[input].ship.health != 0
          p "My shot on #{input} was a hit"
        elsif @board2.cells[input].ship != nil && @board2.cells[input].ship.health == 0
          p "My shot on #{input} was a hit and the ship sunk"
        end

  end

  def computer_attack
    cell = computer.attack
    @board1.cells[cell].fire_upon
    @board1.render(true)
# if cell == nil
#   binding.pry
# elsif board1.cells[cell].ship.health

    if @board1.cells[cell].ship == nil
      p "The computer's shot on #{cell} was a miss"
    elsif @board1.cells[cell].ship != nil && @board1.cells[cell].ship.health != 0
      p "The computer's shot on #{cell} was a hit"
    elsif @board1.cells[cell].ship != nil && @board1.cells[cell].ship.health == 0
      p "The computer's shot on #{cell} was a hit and the ship sunk"
    end
  end


  def win
    if @cruiser1.sunk? == true && @submarine1.sunk? == true
       p "The Computer Won ... Better Luck Next Time!!!"
    else
       p "You Won!!!"
    end

  end



  def start
    welcome
    if @welcome == true
    cruiser_assignment
    submarine_assignment
    computer_assignment
    display_the_board
    until @cruiser1.sunk? == true && @submarine1.sunk? == true || @cruiser2.sunk? == true && @submarine2.sunk? == true
      fire
      computer_attack
      display_the_board
    end
    win
end
  end




end
