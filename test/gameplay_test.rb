require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/gameplay'

class ShipTest < Minitest::Test

  def test_the_welcome_method
    board = Board.new
    game = Gameplay.new(board)
    submarine =Ship.new("submarine", 2)
    cruiser = Ship.new("cruiser", 3)
    game.welcome
    game.cruiser_assignment
    game.submarine_assignment



  end

end
