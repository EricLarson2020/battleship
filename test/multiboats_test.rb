require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/gameplay'
require './lib/computer'
require './lib/player'
require './lib/multiboats'

class MultiboatsTest < Minitest::Test

  def test_it_exists
    multiboats = Multiboats.new(1)
    assert_instance_of Multiboats, multiboats
  end

  def test_user_input
    skip
    multiboats = Multiboats.new(1)
    multiboats.ship_name_input
    multiboats.ship_length_input
    multiboats.create_ship
  end

  def test_ship_loop
    multiboats = Multiboats.new(2)
    multiboats.ship_loop
    assert_equal 2, multiboats.ships.length
  end

end
