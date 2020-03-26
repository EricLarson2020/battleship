require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/gameplay'

class ShipTest < Minitest::Test

  def test_it_exists
    board1 = Board.new
    board2 = Board.new
    gameplay = Gameplay.new(board1, board2)

    assert_instance_of Gameplay, gameplay
  end

  def test_game_over

    board1 = Board.new
    board2 = Board.new
    computer = Computer.new(board2)
    game = Gameplay.new(board1, board2, computer)
    # submarine =Ship.new("submarine", 2)
    # cruiser = Ship.new("cruiser", 3)
    # game.welcome
    # game.cruiser_assignment
    # game.submarine_assignment
    # cruiser = Ship.new("Cruiser", 1)
    # board1.place(cruiser, ["A1"])
    # board2.place(cruiser, ["B3"])

    # game.start

    game.start
    game.play_loop
  end


end
