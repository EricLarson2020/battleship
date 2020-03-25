require "pry"

class Computer

  attr_reader :board, :cell_list, :attack_cell, :ship1, :ship2
  def initialize(board)
    @board = board
    @cell_list = @board.cells.keys
    @attack_cell_list = @cell_list
    @place_cell_list = @cell_list
    @attack_cell = nil
    @ship1 = Ship.new("Cruiser", 3)
    @ship2 = Ship.new("Submarine", 2)
  end

  def attack
    if !@attack_cell_list.empty?
      @attack_cell = @attack_cell_list.shuffle[0]
      index = @attack_cell_list.index(attack_cell)
      @attack_cell_list.delete_at(index)
      @attack_cell
    else
      @attack_cell = nil
    end
  end

  def auto_coordinates(ship)
    ship_cells = []
    until board.valid_placement?(ship, ship_cells) do
      ship_cells = @place_cell_list.shuffle[0..(ship.length-1)]
    end
    ship_cells.each do |cell|
      index = @place_cell_list.index(cell)
      @place_cell_list.delete(cell)
    end
    ship_cells
  end


end
