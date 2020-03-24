require 'minitest/autorun'
require 'minitest/pride'

require './lib/board'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_cells_are_returned
    board = Board.new
    cells ={"A1" => "cell", "A2" => "cell", "A3" => "cell", "A4" => "cell",
          "B1" => "cell", "B2" => "cell", "B3" => "cell", "B4" => "cell",
          "C1" => "cell", "C2" => "cell", "C3" => "cell", "C4" => "cell",
          "D1" => "cell", "D2" => "cell", "D3" => "cell", "D4" => "cell"}
    assert_equal cells, board.cells
  end

  def test_determines_if_cells_are_valid
    board = Board.new


    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?(:A1)
    assert_equal false, board.valid_coordinate?("D9")
    assert_equal false, board.valid_coordinate?(10)
  end

end #final
