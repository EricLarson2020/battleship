require 'minitest/autorun'
require 'minitest/pride'

require './lib/computer'
require './lib/board'
require './lib/ship'

class ComputerTest < Minitest::Test

  def test_it_exists
    board = Board.new
    computer = Computer.new(board)

    assert_instance_of Computer, computer
  end

  def test_it_picks_new_cells
    board = Board.new
    computer = Computer.new(board)
    computer.attack

    assert_equal true, board.valid_coordinate?(computer.attack_cell)
  end

  def test_it_cant_pick_if_cell_list_is_empty
    board = Board.new
    computer = Computer.new(board)
    computer.attack # 1
    assert_equal true, board.valid_coordinate?(computer.attack_cell)
    computer.attack # 2
    computer.attack # 3
    computer.attack # 4
    computer.attack # 5
    computer.attack # 6
    computer.attack # 7
    computer.attack # 8
    computer.attack # 9
    computer.attack # 10
    computer.attack # 11
    computer.attack # 12
    computer.attack # 13
    computer.attack # 14
    computer.attack # 15
    assert_equal true, board.valid_coordinate?(computer.attack_cell)
    computer.attack # 16
    computer.attack # 17
    #binding.pry
    assert_nil computer.attack_cell

  end

  def test_it_can_place_valid_ships
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Sumbarine", 2)
    computer = Computer.new(board, cruiser)
    cruiser_auto_place = computer.auto_coordinates(cruiser)
    submarine_auto_place = computer.auto_coordinates(submarine)

    assert_equal true, board.valid_placement?(cruiser, cruiser_auto_place)
    assert_equal true, board.valid_placement?(submarine, submarine_auto_place)

    board.place(cruiser, cruiser_auto_place)
    board.place(submarine, submarine_auto_place)
    puts board.render(true)
    # binding.pry

  end
end
