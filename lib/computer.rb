require "pry"

class Computer

  attr_reader :board1, :cell_list, :attack_cell, :ship1, :ship2
  def initialize(board1, board2 = false)
    @board1 = board1
    @board2 = board2
    @cell_list = @board1.cells.keys
    @attack_cell_list = @board1.cells.keys
    @place_cell_list = @board1.cells.keys
    @attack_cell = nil
    @ship1 = Ship.new("Cruiser", 3)
    @ship2 = Ship.new("Submarine", 2)
  end

  def auto_coordinates(ship)
    ship_cells = []
    until board1.valid_placement?(ship, ship_cells) do
      ship_cells = @place_cell_list.shuffle[0..(ship.length-1)]
    end
    ship_cells.each do |cell|
      index = @place_cell_list.index(cell)
      @place_cell_list.delete(cell)
    end
    ship_cells
  end

  def attack
    # binding.pry
    if !@attack_cell_list.empty?
      @attack_cell = @attack_cell_list.shuffle[0]
      index = @attack_cell_list.index(attack_cell)
      @attack_cell_list.delete_at(index)
      @attack_cell_list
      @attack_cell
    else
      @attack_cell = nil
    end
  end
  # if status is hit
  #   attack adjacent
  #   if status is missed
  #     do random
  def smart_attack
    if @board2.cells[@attack_cell].status == :missed || @board2.cells[@attack_cell].status == :sunk
      attack
    elsif @board.cells[@attack_cell].status
      #code
    end
  end

  def adjacent_cells(cell)
    letter = cell[0]
    number = cell[1].to_i

    num_minus = (number - 1).to_s
    num_plus = (number + 1).to_s
    letter_minus = (letter.ord - 1).chr
    letter_plus = (letter.ord + 1).chr

    adj1 = letter_minus + number.to_s
    adj2 = letter_plus + number.to_s
    adj3 = letter + num_plus
    adj4 = letter + num_minus

    p [adj1, adj2, adj3, adj4]


  end



end
