require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/gameplay'

class ShipTest < Minitest::Test

  def test_p_input_starts_the_game

    game = Gameplay.new
    cruiser = Ship.new("Cruiser", 3)

  game.begin
  


  end

end
