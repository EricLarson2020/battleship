require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/gameplay'

class ShipTest < Minitest::Test

  def test_it_exists
    board = Board.new
    gameplay = Gameplay.new(board)

    assert_instance_of Gameplay, gameplay
  end

  def test_p_input_starts_the_game
    skip
    board = Board.new
    gameplay = Gameplay.new(board)
    cruiser = Ship.new("Cruiser", 3)

    gameplay.welcome

    assert_equal true, gameplay.play

  end

  def test_it_prompts_for_ship_inputs
    skip
    board = Board.new
    gameplay = Gameplay.new(board)
    cruiser = Ship.new("Cruiser", 3)

    gameplay.cruiser_placement_prompt

  end

  def test_it_places_valid_ships_on_board
    board = Board.new
    gameplay = Gameplay.new(board)
    cruiser = Ship.new("Cruiser", 3)

    gameplay.cruiser_placement
  end



end
