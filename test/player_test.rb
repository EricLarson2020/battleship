require 'minitest/autorun'
require 'minitest/pride'

require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/gameplay'
require './lib/player'
require './lib/computer'

class PlayerTest < Minitest::Test

  def test_it_exists
    board_user = Board.new
    board_computer = Board.new
    player = Player.new(board_user, board_computer)
    assert_instance_of Player, player
  end

  def test_it_has_boards
    board_user = Board.new
    board_computer = Board.new
    player = Player.new(board_user, board_computer)
    assert_equal board_computer, player.board_computer
    assert_equal board_user, player.board_user

  end

  def test_cell_status
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    player = Player.new(board_user, board_computer)
    computer = Computer.new(board_user, board_computer)
    fire = "A1"
    board_user.place(cruiser1, ["B1", "B2", "B3"])
    board_user.cells[fire].fire_upon
    board_user.cells["B1"].fire_upon
    assert_equal :missed, player.cell_status(fire)
    assert_equal :not_hit, player.cell_status("A2")
     assert_equal :hit, player.cell_status("B1")
  end
end
