require './lib/board'
require './lib/cell'
require './lib/ship'
require "pry"
class Gameplay

  attr_reader :play
  def initialize(board)
    @board = board
    @play = play
    @cruiser_coordinates1 = nil
    @cruiser_coordinates2 = nil
    @submarine_coordiantes1 = nil
    @sumbarine_coordiantes2 = nil
  end


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


      def welcome
        input = ''
        until input == 'p'
          puts "Welcome to BATTLESHIP"
          puts" Enter p to play. Enter q to quit."
          input = gets.chomp.downcase
          if input == "p"
            @play = true
            puts "Game On!"
          elsif input == "q"
            @play = false
            puts "Come back soon!"
            break
          else
            puts "Invalid input"
          end
        end
        @play
      end

      def cruiser_placement_prompt
        if welcome
          puts "I have laid out my ships on the grid.
                You now need to lay out your two ships.
                The Cruiser is three units long and the Submarine is two units long.
                  1 2 3 4
                A . . . .
                B . . . .
                C . . . .
                D . . . .
                Enter the squares for the Cruiser (3 spaces):"

          input = gets.chomp
          @cruiser_coordinates1 = input.split(", ")

        end
      end

      def cruiser_placement
        cruiser = Ship.new("Cruiser", 3)
        cruiser_placement_prompt

        until @board.valid_placement?(cruiser, @cruiser_coordinates1)
            puts "Those are invalid coordinates. Please try again"
            input = gets.chomp
            @cruiser_coordinates1 = input.split(", ")
        end

        @board.place(cruiser, @cruiser_coordinates1)
        puts @board.render(true)
        puts "Enter the squares for the Submarine"
        input = gets.chomp
        @submarine_coordinates1 = input.split(", ")
      end

      def submarine_plaement
        submarine = Ship.new("Submarine", 2)
        cruiser_placement_prompt

        until @board.valid_placement?(submarine, @submarine_coordinates1)
            puts "Those are invalid coordinates. Please try again"
            input = gets.chomp
            @cruiser_coordinates1 = input.split(", ")
        end

      end




end # final
