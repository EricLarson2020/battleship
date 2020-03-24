require "pry"

class Computer

  attr_reader :board, :cell_list, :attack_cell
  def initialize(board)
    @board = board
    @cell_list = @board.cells.keys
    @attack_cell

  end

  def attack
    if !@cell_list.empty?
      @attack_cell = @cell_list.shuffle[0]
      index = @cell_list.index(attack_cell)
      @cell_list.delete_at(index)
      @attack_cell
    end
  end

end
