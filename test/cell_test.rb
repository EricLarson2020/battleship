require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class ShipTest < Minitest::Test

  def test_it_exists
    cell = Cell.new("B4")
    assert_instance_of Cell, cell
  end

  def test_it_has_a_coordinate
    cell = Cell.new("B4")
    assert_equal "B4", cell.coordinate
  end

  def test_if_cell_starts_with_no_ship
    cell = Cell.new("B4")
    assert_equal nil, cell.ship
  end

  def test_if_cell_is_empty
    cell = Cell.new("B4")
    assert_equal true, cell.empty?
  end

  def test_place_ship_in_cell_method
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
    assert_equal false, cell.empty?
  end

  def test_when_ship_is_fired_upon_it_loses_health
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    assert_equal false, cell.fired_upon?
    cell.fire_upon
    assert_equal 2, cell.ship.health
    assert_equal true, cell.fired_upon?
  end

  def test_cell_render_when_not_fired_upon
    cell_1 = Cell.new("B4")
    assert_equal ".", cell_1.render
    assert_equal :not_hit, cell_1.status
  end

  def test_cell_render_when_fired_upon_and_missed
    cell_1 = Cell.new("B4")
    cell_1.fire_upon
    assert_equal "M", cell_1.render
    assert_equal :missed, cell_1.status
  end

  def test_cell_render_when_fired_upon_and_ship_hit_and_ship_sunk
    cell_1 = Cell.new("B4")
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    assert_equal ".", cell_2.render
    assert_equal :not_hit, cell_2.status
    # assert_equal "S", cell_2.render(true)
    cell_2.fire_upon
    assert_equal "H", cell_2.render
    assert_equal :hit, cell_2.status
    assert_equal false, cruiser.sunk?
    cruiser.hit
    cruiser.hit
    assert_equal true, cruiser.sunk?
    assert_equal "X", cell_2.render
    assert_equal :sunk, cell_2.status

  end
end


#
# # Indicate that we want to show a ship with the optional argument
# pry(main)> cell_2.render(true)
# # => "S"
