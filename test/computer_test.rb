require 'minitest/autorun'
require 'minitest/pride'

require './lib/computer'
require './lib/board'

class ComputerTest < Minitest::Test

  def test_it_exists
    board = Board.new
    computer = Computer.new(board)

    assert_instance_of Computer, computer
  end

  def test_it_picks_new_cells
    board = Board.new
    computer = Computer.new(board)

    assert_equal true, board.valid_coordinate?(computer.attack_cell)
  end


end
