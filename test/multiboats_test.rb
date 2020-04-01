require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
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

  # def test_create_ship
  #   multiboats = Multiboats.new(1)
  #   multiboats.stubs(:ship_name_input).returns("Bob the ship")
  #   multiboats.stubs(:ship_length_input).returns(3)
  #   expected = Ship.new(nil, nil)
  #   assert_equal [expected], multiboats.create_ship
  # end

  def test_ship_loop
    skip
    multiboats = Multiboats.new(2)
    multiboats.ship_loop
    assert_equal 2, multiboats.ships.length
  end

end
