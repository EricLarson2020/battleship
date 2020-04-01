require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/gameplay'
require './lib/computer'
require './lib/player'
require './lib/multiboats'

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

  def test_welcome_statement
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
    assert_equal true, game.welcome_statement("p")
    assert_equal false, game.welcome_statement("ald")
  end

  def test_player_placement_valid
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
    game.player_placement_valid(submarine1, ["A1", "A2"])

    assert_equal "Submarine", board_user.cells["A1"].ship.name
    assert_equal "Submarine", board_user.cells["A2"].ship.name
    assert_equal nil, board_user.cells["A4"].ship
    assert_equal nil, board_user.cells["B3"].ship
  end

  def test_computer_placement

    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
    game.computer_placement
    # require "pry";binding.pry

    ship_cells = board_computer.cells.count do |cell|
    cell[1].ship != nil
    end
    # require "pry";binding.pry
    assert_equal 5, ship_cells
  end

  def test_coordinates_are_validated
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
    input = "A4"
    assert_equal "A4", game.coordinates_are_validated(input)
  end



  def test_player_fire_on
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_computer, board_user)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)

    board_computer.place(submarine2, ["A1", "A2"])
    game.player_fire_on("A1")
    assert_equal false, game.player_cell_list.include?("A1")

    assert_equal true, board_computer.cells["A1"].fired_upon?
  end

  def test_status_board_computer
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_computer, board_user)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
    board_computer.place(submarine2, ["A2", "A3"])
    board_computer.cells["A2"].fire_upon
    assert_equal :hit, game.status_board_computer("A2")
    assert_equal :not_hit, game.status_board_computer("A4")
    board_computer.cells["A3"].fire_upon
    assert_equal :sunk, game.status_board_computer("A3")
  end

  def test_player_call_result
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_computer, board_user)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
    board_computer.place(submarine2, ["A2", "A3"])
    board_computer.cells["A2"].fire_upon
    cell_input = "A2"
    hit_input = "Your shot on #{cell_input} was a hit!"
    assert_equal hit_input, game.player_call_result(cell_input)
    cell_input = "A4"
    miss_input = "Your shot on #{cell_input} was a miss."
    board_computer.cells["A4"].fire_upon
    assert_equal miss_input, game.player_call_result(cell_input)
    board_computer.cells["A3"].fire_upon
    cell_input = "A3"
    sunk_input = "You sunk computer's #{board_computer.cells[cell_input].ship.name}!"
    assert_equal sunk_input, game.player_call_result(cell_input)
  end

  def test_computer_pick_cell_and_fires_on_it
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
    board_computer.place(submarine2, ["A2", "A3"])
    input = game.computer_picks_cell_and_fires_on_it
    assert_equal true, board_user.cells[input].fired_upon?
    end

    def test_computer_hit_miss_or_sunk_statement
      cruiser1 = Ship.new("Cruiser", 3)
      submarine1 = Ship.new("Submarine", 2)
      cruiser2 = Ship.new("Cruiser", 3)
      submarine2 = Ship.new("Submarine", 2)
      board_user = Board.new
      board_computer = Board.new
      computer = Computer.new(board_user, board_computer)
      player = Player.new(board_user, board_computer)
      game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
      board_user.place(submarine2, ["A2", "A3"])
      input = "A4"
      board_user.cells["A4"].fire_upon
      computer_miss = "Computer's shot on #{input} was a miss."
      assert_equal computer_miss, game.computer_hit_miss_or_sunk_statement(input)
      board_user.cells["A3"].fire_upon
      board_user.render

      input = "A3"
      # require"pry";binding.pry
      computer_hit = "Computer's shot on #{input} was a hit!"
      assert_equal computer_hit, game.computer_hit_miss_or_sunk_statement(input)
      board_user.cells["A2"].fire_upon
      input = "A2"
      computer_sunk = "Computer sunk your #{board_user.cells[input].ship.name}!"
      assert_equal computer_sunk, game.computer_hit_miss_or_sunk_statement(input)
    end

    def test_board_render
      cruiser1 = Ship.new("Cruiser", 3)
      submarine1 = Ship.new("Submarine", 2)
      cruiser2 = Ship.new("Cruiser", 3)
      submarine2 = Ship.new("Submarine", 2)
      board_user = Board.new
      board_computer = Board.new
      computer = Computer.new(board_computer, board_user)
      player = Player.new(board_user, board_computer)
      game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
          expected = "  1 2 3 4 \n" +
                     "A . . . . \n" +
                     "B . . . . \n" +
                     "C . . . . \n" +
                     "D . . . . \n"

      assert_equal expected, game.board_render
      board_user.place(submarine2, ["A2", "A3"])
      expected = "  1 2 3 4 \n" +
                 "A . S S . \n" +
                 "B . . . . \n" +
                 "C . . . . \n" +
                 "D . . . . \n"

      assert_equal expected, game.board_render
      board_user.cells["A2"].fire_upon
      expected = "  1 2 3 4 \n" +
                 "A . H S . \n" +
                 "B . . . . \n" +
                 "C . . . . \n" +
                 "D . . . . \n"
      assert_equal expected, game.board_render
      board_user.cells["A3"].fire_upon
      expected = "  1 2 3 4 \n" +
                 "A . X X . \n" +
                 "B . . . . \n" +
                 "C . . . . \n" +
                 "D . . . . \n"
      assert_equal expected, game.board_render
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


def test_win_or_lose_statement_for_computer
  cruiser1 = Ship.new("Cruiser", 3)
  submarine1 = Ship.new("Submarine", 2)
  cruiser2 = Ship.new("Cruiser", 3)
  submarine2 = Ship.new("Submarine", 2)
  board_user = Board.new
  board_computer = Board.new
  computer = Computer.new(board_user, board_computer)
  player = Player.new(board_user, board_computer)
  game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
  cruiser1.hit
  cruiser1.hit
  cruiser1.hit
  submarine1.hit
  submarine1.hit
  computer_win = "Computer has won the game!"
  assert_equal computer_win, game.win_or_lose_statement
end

def test_win_or_lose_statement_for_user
  cruiser1 = Ship.new("Cruiser", 3)
  submarine1 = Ship.new("Submarine", 2)
  cruiser2 = Ship.new("Cruiser", 3)
  submarine2 = Ship.new("Submarine", 2)
  board_user = Board.new
  board_computer = Board.new
  computer = Computer.new(board_user, board_computer)
  player = Player.new(board_user, board_computer)
  game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
  cruiser2.hit
  cruiser2.hit
  cruiser2.hit
  submarine2.hit
  submarine2.hit
  user_win = "Human has won the game!"
  assert_equal user_win, game.win_or_lose_statement
end

def test_computer_loss?
  cruiser1 = Ship.new("Cruiser", 3)
  submarine1 = Ship.new("Submarine", 2)
  cruiser2 = Ship.new("Cruiser", 3)
  submarine2 = Ship.new("Submarine", 2)
  board_user = Board.new
  board_computer = Board.new
  computer = Computer.new(board_user, board_computer)
  player = Player.new(board_user, board_computer)
  game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
  cruiser2.hit
  cruiser2.hit
  cruiser2.hit
  assert_equal true, cruiser2.sunk?
  submarine2.hit
  assert_equal false, game.computer_loss?
  submarine2.hit
  assert_equal true, submarine2.sunk?
  assert_equal true, game.computer_loss?
  end

  def test_player_loss?
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
    cruiser1.hit
    cruiser1.hit
    assert_equal false, game.player_loss?
    cruiser1.hit
    assert_equal true, cruiser1.sunk?
    submarine1.hit
    assert_equal false, submarine1.sunk?
    submarine1.hit
    assert_equal true, submarine1.sunk?
    assert_equal true, game.player_loss?
  end

  def test_game_over?
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    player = Player.new(board_user, board_computer)
    game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2)
    cruiser1.hit
    cruiser1.hit
    assert_equal false, game.game_over?
    cruiser1.hit
    submarine2.hit
    submarine2.hit
    assert_equal true, submarine2.sunk?
    submarine1.hit
    submarine1.hit
    assert_equal true, game.player_loss?
    assert_equal true, game.game_over?
  end
end
