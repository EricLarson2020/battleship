require "pry"

class Computer

  attr_reader :board, :cell_list, :attack_cell
  def initialize(board, ship1 = nil, ship2 = nil)
    @board = board
    @cell_list = @board.cells.keys
    @attack_cell
    @ship1 = ship1
    @ship2 = ship2
  end

  def attack
    if !@cell_list.empty?
      @attack_cell = @cell_list.shuffle[0]
      index = @cell_list.index(attack_cell)
      @cell_list.delete_at(index)
      @attack_cell
    else
      @attack_cell = nil
    end
  end

end
