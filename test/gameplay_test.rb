require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/gameplay'
require './lib/computer'
require './lib/player'

class GameplayTest < Minitest::Test

  def test_it_exists
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_computer, board_user)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)

    assert_instance_of Gameplay, game
  end

  def test_player_fires_on_cell
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_computer, board_user)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)


    game.player_fire_on("A1")
    game.board_computer.cells["A1"].render

    assert_equal :missed, game.status_board_computer("A1")
  end

  def test_it_calls_players_shots_correctly
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)

    board_computer.place(cruiser2, ["A1", "A2", "A3"])

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

  def test_for_the_play_loop
    skip
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
    win = "Human has won the game!"
    loss ="Computer has won the game!"
    game.cruiser_assignment
    game.submarine_assignment
    computer_placement
    assert_equal win, game.play_loop


  end

  def test_player_start
    skip
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)


  end

  def test_welcome_statement
    skip
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)


  end

  def test_player_placement_valid
    skip
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
  end

  def test_cruiser_assignment
    skip
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
  end

  def test_submarine_assignment
    skip
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
  end
end
