require 'minitest/autorun'
require 'minitest/pride'

require './lib/board'
require './lib/cell'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new
    #binding.pry

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

  def test_it_places_ships_in_cells
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    #board.place(cruiser, ["A1", "A2", "A3"])
    board.place(cruiser, ["A1", "A2", "A3"])
    #binding.pry
    cell_A1 = board.cells["A1"]
    cell_A2 = board.cells["A2"]
    cell_A3 = board.cells["A3"]
    cell_A4 = board.cells["A4"]
#binding.pry
    assert_equal "Cruiser", board.cells["A1"].ship.name
    assert_equal "Cruiser", board.cells["A2"].ship.name
    assert_equal "Cruiser", board.cells["A3"].ship.name
    assert_nil board.cells["A4"].ship
    assert_nil board.cells["B1"].ship


  end

  def test_render_displays_empty_board
    board = Board.new
    board.render
    # binding.pry
    expected = "  1 2 3 4 \n" +
               "A . . . . \n" +
               "B . . . . \n" +
               "C . . . . \n" +
               "D . . . . \n"
  assert_equal expected, board.render
  end

  def test_render_displays_specific_misses
    board = Board.new
    board.render
    board.cells["A1"].fire_upon
    board.cells["B2"].fire_upon
    board.cells["C3"].fire_upon
    board.cells["D4"].fire_upon
    # binding.pry
    expected = "  1 2 3 4 \n" +
               "A M . . . \n" +
               "B . M . . \n" +
               "C . . M . \n" +
               "D . . . M \n"
  assert_equal expected, board.render
  end

  def test_render_displays_ships
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["D3", "C3"])

    # binding.pry
    expected = "  1 2 3 4 \n" +
               "A S S S . \n" +
               "B . . . . \n" +
               "C . . S . \n" +
               "D . . S . \n"
  assert_equal expected, board.render(true)
  end

  def test_hit_and_misses_on_the_board
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    #binding.pry
    board.cells["A1"].fire_upon
    board.cells["A2"].fire_upon
    board.cells["B1"].fire_upon
    board.cells["C1"].fire_upon
    board.cells["D3"].fire_upon


    # binding.pry
    expected = "  1 2 3 4 \n" +
               "A H H S . \n" +
               "B M . . . \n" +
               "C M . . . \n" +
               "D . . M . \n"
    assert_equal expected, board.render(true)
    assert_equal false, board.cells["A1"].ship.sunk?
  end

  def test_sink_a_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    #binding.pry
    board.cells["A1"].fire_upon
    board.cells["A2"].fire_upon
    board.cells["B1"].fire_upon
    board.cells["C1"].fire_upon
    board.cells["D3"].fire_upon
    board.cells["A3"].fire_upon


    # binding.pry
    expected = "  1 2 3 4 \n" +
               "A X X X . \n" +
               "B M . . . \n" +
               "C M . . . \n" +
               "D . . M . \n"
    assert_equal expected, board.render(true)
    assert_equal true, board.cells["A1"].ship.sunk?
  end





end #final
