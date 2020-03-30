require 'minitest/autorun'
require 'minitest/pride'

require './lib/computer'
require './lib/board'
require './lib/ship'

class ComputerTest < Minitest::Test

  def test_it_exists
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)

    assert_instance_of Computer, computer
  end

  def test_it_picks_new_cells
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    computer.attack

    assert_equal true, board_computer.valid_coordinate?(computer.attack_cell)
  end

  def test_it_can_delete_cells
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    original_cells = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4"]
    delete_cells = ["A1", "A2", "A3", "A4"]
    expected_list = ["B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4"]

    assert_equal expected_list, computer.delete_cells(original_cells, delete_cells)

  end

  def test_it_cant_pick_if_cell_list_is_empty
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    computer.attack # 1
    assert_equal true, board_computer.valid_coordinate?(computer.attack_cell)
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
    assert_equal true, board_computer.valid_coordinate?(computer.attack_cell)
    computer.attack # 16
    computer.attack # 17
    #binding.pry
    assert_equal '',  computer.attack_cell
  end

  def test_it_can_place_valid_ships
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Sumbarine", 2)

    cruiser_auto_place = computer.auto_coordinates(cruiser)
    submarine_auto_place = computer.auto_coordinates(submarine)

    assert_equal true, board_computer.valid_placement?(cruiser, cruiser_auto_place)
    assert_equal true, board_computer.valid_placement?(submarine, submarine_auto_place)

    board_computer.place(cruiser, cruiser_auto_place)
    board_computer.place(submarine, submarine_auto_place)
    puts board_computer.render(true)
  end

  def test_cell_missed_or_sunk
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    cruiser = Ship.new("Cruiser", 3)
    board_user.place(cruiser, ["A1", "A2", "A3"])
    board_user.cells["A1"].fire_upon
    board_user.cells["B1"].fire_upon
    board_user.cells["A1"].render
    board_user.cells["B1"].render
    # binding.pry
    assert_equal :hit, board_user.cells["A1"].status
    assert_equal false, computer.missed_or_sunk?("A1")
    assert_equal :missed, board_user.cells["B1"].status
    assert_equal true, computer.missed_or_sunk?("B1")

    board_user.cells["A2"].fire_upon
    board_user.cells["A3"].fire_upon
    board_user.cells["A1"].render
    assert_equal :sunk, board_user.cells["A1"].status
    assert_equal true, computer.missed_or_sunk?("A1")

  end

  def test_cell_hit?
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    cruiser = Ship.new("Cruiser", 3)
    board_user.place(cruiser, ["A1", "A2", "A3"])
    board_user.cells["A1"].fire_upon
    board_user.cells["A1"].render
    board_user.cells["B1"].render

    assert_equal :hit, board_user.cells["A1"].status
    assert_equal true, computer.hit?("A1")
    assert_equal :not_hit, board_user.cells["B1"].status
    assert_equal false, computer.hit?("B1")

    board_user.cells["A2"].fire_upon
    board_user.cells["A3"].fire_upon
    board_user.cells["A1"].render
    assert_equal :sunk, board_user.cells["A1"].status
    assert_equal false, computer.hit?("A1")
  end

  def test_it_only_attacks_remaining_cells
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    # binding.pry
    expected_list = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#15
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#14
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#13
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#12
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#11
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#10
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#9
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#8
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#7
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#6
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#5
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#4
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#3
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#2
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#1
    assert_equal true, expected_list.include?(computer.attack)
    expected_list.delete(computer.attack_cell)#0
    assert_equal '', computer.attack

  end

  def test_smart_cell_is_adjacent_and_not_hit
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    cruiser = Ship.new("Cruiser", 3)
    board_user.place(cruiser, ["A1", "A2", "A3"])
    board_user.cells["A1"].fire_upon
    board_user.cells["A1"].render
    board_user.cells["B1"].render

  end

  def test_smart_cells_pick_adjacent_and_not_hit
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    cruiser = Ship.new("Cruiser", 3)
    board_user.place(cruiser, ["A1", "A2", "A3"])
    expected_list = ["A2", "A4", "B3"]

    assert_equal expected_list.sort, computer.smart_cells("A3").sort

    board_user.cells["A2"].fire_upon
    computer.attack_cell_list.delete("A2")
    board_user.cells["A4"].fire_upon
    computer.attack_cell_list.delete("A4")
    board_user.cells["A2"].render
    board_user.cells["A4"].render
    board_user.cells["B3"].render
    expected_list = ["B3"]

    assert_equal expected_list, computer.smart_cells("A3")

    board_user.cells["A2"].fire_upon
    computer.attack_cell_list.delete("A2")
    board_user.cells["A4"].fire_upon
    computer.attack_cell_list.delete("A4")
    board_user.cells["B3"].fire_upon
    computer.attack_cell_list.delete("B3")
    board_user.cells["A2"].render
    board_user.cells["A4"].render
    board_user.cells["B3"].render
    expected_list = []

    assert_equal expected_list, computer.smart_cells("A3")
  end

  def test_smart_attack_cell_picks_from_smart_cell_list_3_avail
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    cruiser = Ship.new("Cruiser", 3)
    board_user.place(cruiser, ["A1", "A2", "A3"])
    board_user.cells["A3"].fire_upon
    board_user.cells["A2"].render
    board_user.cells["A3"].render
    board_user.cells["A4"].render
    board_user.cells["B2"].render
    board_user.cells["B3"].render
    board_user.cells["B4"].render
    expected_list = ["A2", "A4", "B3"]
    actual_attack_cell = computer.smart_attack_cell("A3")

    assert_equal true, expected_list.include?(actual_attack_cell)
    assert_equal false, computer.attack_cell_list.include?(actual_attack_cell)
  end

  def test_smart_attack_cell_picks_from_smart_cell_list_2_avail
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    cruiser = Ship.new("Cruiser", 3)
    board_user.place(cruiser, ["A1", "A2", "A3"])
    board_user.cells["A3"].fire_upon
    computer.attack_cell_list.delete("A3")
    board_user.cells["A4"].fire_upon
    computer.attack_cell_list.delete("A4")
    board_user.cells["A2"].render
    board_user.cells["A3"].render
    board_user.cells["A4"].render
    board_user.cells["B2"].render
    board_user.cells["B3"].render
    board_user.cells["B4"].render
    expected_list = ["A2", "B3"]
    actual_attack_cell = computer.smart_attack_cell("A3")

    assert_equal true, expected_list.include?(actual_attack_cell)
    assert_equal false, computer.attack_cell_list.include?(actual_attack_cell)
  end

  def test_smart_attack_attacks_random_on_first_and_not_hit
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    cruiser = Ship.new("Cruiser", 3)
    board_user.place(cruiser, ["A1", "A2", "A3"])
    original_cells = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    computer.smart_attack
    assert_equal true, original_cells.include?(computer.attack_cell)
    board_user.cells[computer.attack_cell].fire_upon
    board_user.render
    computer.smart_attack
    assert_equal true, original_cells.include?(computer.attack_cell)
  end

  def test_smart_attack_attacks_adjacent_cells_if_hit
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)
    cruiser = Ship.new("Cruiser", 4)
    board_user.place(cruiser, ["A1", "A2", "A3", "A4"])
    board_user.place(cruiser, ["B1", "B2", "B3", "B4"])
    board_user.place(cruiser, ["C1", "C2", "C3", "C4"])
    board_user.place(cruiser, ["D1", "D2", "D3", "D4"])
    computer.smart_attack
    board_user.render
    past_attack_cell = computer.attack_cell
    board_user.cells[past_attack_cell].fire_upon
    board_user.render
    # binding.pry
    assert_equal :hit, board_user.cells[past_attack_cell].status
    computer.smart_attack
    # binding.pry
    assert_equal true, computer.adjacent_cells(past_attack_cell).include?(computer.attack_cell)
  end


  def test_it_can_identify_adjacent_cells
    board_user = Board.new
    board_computer = Board.new
    computer = Computer.new(board_user, board_computer)

    computer.adjacent_cells("A1")
    assert_equal ["B2", "D2", "C3", "C1"], computer.adjacent_cells("C2")
  end


end
