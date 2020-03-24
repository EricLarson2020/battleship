require 'minitest/autorun'
require 'minitest/pride'

require './lib/board'
require './lib/cell'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end


  def test_cells_are_returned
    board = Board.new
    cell_1 = board.cells["A1"]

    cells =["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4",
            "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    assert_equal cells, board.cells.keys
  end

  def test_determines_if_cells_are_valid
    board = Board.new


    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_determines_if_placement_coordinates_are_sequential_in_x_direction
    board = Board.new

    assert_equal true, board.x_coordinates_sequential?(["A1", "A2", "A3"])
    assert_equal true, board.x_coordinates_sequential?(["A2", "A1"])
    assert_equal false, board.x_coordinates_sequential?(["A1", "A4"])
    assert_equal false, board.x_coordinates_sequential?(["A1", "B2"])


  end

  def test_determines_if_placement_coordinates_are_sequential_in_y_direction
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal true, board.y_coordinates_sequential?(["A1", "B1", "C1"])
    assert_equal true, board.y_coordinates_sequential?(["C2", "B2", "A2"])
    assert_equal false, board.y_coordinates_sequential?(["A1", "B2", "C3"])
    assert_equal false, board.y_coordinates_sequential?(["C2", "A2", "B2"])
    assert_equal false, board.y_coordinates_sequential?(["A1", "B2"])
  end

  def test_determines_if_placement_coordinates_are_sequential_in_y_direction
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal true, board.valid_placement?(cruiser, ["A1", "B1", "C1"])
    assert_equal true, board.valid_placement?(cruiser, ["C2", "B2", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["C1", "C2", "C3"])
    assert_equal false, board.valid_placement?(cruiser, ["E1", "E2", "E3"])

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(cruiser, ["C2", "A2", "B2"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2"])

  end





end #final
