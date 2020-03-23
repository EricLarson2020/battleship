require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    cruiser = Ship.new("Cruiser", 3)
    assert_instance_of Ship, cruiser
  end

  def test_it_has_a_name
    cruiser = Ship.new("Cruiser", 3)
    assert_equal "Cruiser", cruiser.name
  end

  def test_it_has_length
    cruiser = Ship.new("Cruiser", 3)
    assert_equal 3, cruiser.length
  end

  def test_it_has_health_equal_to_length
    cruiser = Ship.new("Cruiser", 3)
    assert_equal 3, cruiser.health
  end

  def test_ship_sunk_status
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, cruiser.sunk?
  end

  def test_ship_hit_reduces_health
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    assert_equal 2, cruiser.health
  end
end

#
#
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.health
# #=> 2
#
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.health
# #=> 1
#
# pry(main)> cruiser.sunk?
# #=> false
#
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.sunk?
# #=> true
