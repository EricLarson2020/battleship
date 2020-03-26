require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/gameplay'
require './lib/computer'

class GameplayTest < Minitest::Test

  def test_it_exists
    board1 = Board.new
    board2 = Board.new
    gameplay = Gameplay.new(board1, board2)

    assert_instance_of Gameplay, gameplay
  end

  def test_player_fires_on_cell
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_computer, board_user)
    game = Gameplay.new(board_user, board_computer, computer)


    game.player_fire_on("A1")
    game.board_computer.cells["A1"].render

    assert_equal :missed, game.status_board_computer("A1")
  end

  def test_it_calls_players_shots_correctly
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_computer, board_user)
    game = Gameplay.new(board_user, board_computer, computer)
    cruiser = Ship.new("Cruiser", 3)
    board_computer.place(cruiser, ["A1", "A2", "A3"])

    game.player_fire_on("B1")
    game.status_board_computer("B1")
    expected = "Your shot on B1 was a miss."
    assert_equal expected, game.player_call_result("B1")

    game.player_fire_on("A1")
    game.status_board_computer("A1")
    expected = "Your shot on A1 was a hit!"
    assert_equal expected, game.player_call_result("A1")

    game.player_fire_on("A2")
    game.player_fire_on("A3")
    game.status_board_computer("A1")
    expected = "You sunk computer's Cruiser!"
    assert_equal expected, game.player_call_result("A1")

  end


end
