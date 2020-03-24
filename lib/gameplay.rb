require './lib/board'
require './lib/cell'
require './lib/ship'
require "pry"
class Gameplay

def welcome
  p "Welcome to BATTLESHIP"
  p "Enter p to play. Enter q to quit."

  input = gets.chomp
  if input = "p"

                "  1 2 3 4 \n" +
               "A . . . . \n" +
               "B . . . . \n" +
               "C . . . . \n" +
               "D . . . . \n"

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
    input_2 = gets.chomp
    input_2 = input_2.split(" ")
    if board.valid_placement?(cruiser, input_2) != true
      loop do until board.valid_placement?(cruiser, input_2) == true
        p "Those are invalid coordinates. Please try again:"
        input_2 = gets.chomp
        input_2 = input_2.split(" ")
      end
    end
  end

  def submarine_assignment
    input_3 = gets.chomp
    input_3 = input_3.split(" ")
    if board.valid_placement?(submarine, input_3) != true
      loop do until board.valid_placement?(submarine, input_3) == true
        p "Those are invalid coordinates. Please try again:"
        input_3 = gets.chomp
        input_3 = input_3.split(" ")
      end
      end
    end
  end

  def start

  end



end
