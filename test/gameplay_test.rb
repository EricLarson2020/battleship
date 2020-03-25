require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/gameplay'

class ShipTest < Minitest::Test

  def test_it_exists
    board = Board.new
    gameplay = Gameplay.new(board)

    assert_instance_of Gameplay, gameplay
  end

  def test_the_welcome_method
    board = Board.new
    game = Gameplay.new(board)
    submarine =Ship.new("submarine", 2)
    cruiser = Ship.new("cruiser", 3)
    # game.welcome
    # game.cruiser_assignment
    # game.submarine_assignment

    # game.start
    # game.display_the_board
    game.fire
  end



end
