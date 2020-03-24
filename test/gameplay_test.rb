require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/gameplay'

class ShipTest < Minitest::Test

  def test_the_welcome_method
    game = Gameplay.new
    assert_equal game.welcome



  end

end
