require './lib/board'
require './lib/cell'
require './lib/ship'
require "pry"
class Gameplay



  def begin
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
      p "Enter the squares for the Cruiser (3 spaces):"


  board = Board.new

      input_2 = gets.chomp
      input_2.split(",")
      if input_2.include? (" ")
        input.gsub(" ","")
      end

      require "pry";binding.pry
        input_2.split(",")

      # input_2.map do |coor|
      #   coor.to_s
      # end
      binding.pry
      board.place(cruiser, input_2)




      end
    end

#     def start
#       p "Welcome to BATTLESHIP"
#       p "Enter p to play. Enter q to quit."
#
#       input = gets.chomp.downcase
#         if input = p
#
#           board = "  1 2 3 4 \n" +
#                      "A . . . . \n" +
#                      "B . . . . \n" +
#                      "C . . . . \n" +
#                      "D . . . . \n"
#
#           p "I have laid out my ships on the grid."
#           p "You now need to lay out your two ships."
#           p "The Cruiser is three units long and the Submarine is two units long."
#           p board
#           p "Enter the squares for the Cruiser (3 spaces):"
#
#
#
#
#
#
# end
#
#
#
#   end


end
