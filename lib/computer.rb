require "pry"

class Computer

  attr_reader :board_computer,
              :attack_cell,
              :attack_cell_list
#two board types board object and boolean--do keep the boards the same
  def initialize(board_user, board_computer)
    @board_computer = board_computer
    @board_user = board_user
    @attack_cell_list = @board_computer.cells.keys
    @place_cell_list = @board_computer.cells.keys
    @attack_cell = ''

  end

  def delete_cells(original, delete)
    original.reject do |cell|
      delete.include?(cell)
    end
  end
#Extra first call
  def auto_coordinates(ship)
    ship_cells = []
    until board_computer.valid_placement?(ship, ship_cells) do
      ship_cells = @place_cell_list.shuffle[0..(ship.length-1)]
    end
    delete_cells(@place_cell_list, ship_cells)
    ship_cells
  end

  def attack

    if !@attack_cell_list.empty?
      @attack_cell = @attack_cell_list.shuffle[0]
      @attack_cell_list.delete(@attack_cell)
      puts "random attack"
      @attack_cell
      # binding.pry
    else
      @attack_cell = ''
    end
  end

  def missed_or_sunk?(previous_cell)
    @board_user.cells[previous_cell].status == :missed || @board_user.cells[previous_cell].status == :sunk

  end

  def hit?(previous_cell)
    @board_user.cells[previous_cell].status == :hit
  end

  def smart_cells(previous_cell)
    adjacent_cells(previous_cell).find_all do |cell|
      @attack_cell_list.include?(cell)
    end
  end

  def smart_attack_cell(previous_cell)
    if smart_cells(previous_cell) == []
      attack
    elsif smart_cells(previous_cell) != []
      @attack_cell = smart_cells(previous_cell).shuffle[0]
      @attack_cell_list.delete(@attack_cell)
      puts "SMART ATTACK!"
      @attack_cell
    end
  end

  def smart_attack
    if @attack_cell == ''
      attack
    elsif missed_or_sunk?(@attack_cell)
      attack
    elsif hit?(@attack_cell)
      smart_attack_cell(@attack_cell)
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

    adj_cells = [adj1, adj2, adj3, adj4]
    #toss out invalid cells ( A - 1 = @ )
    adj_cells2 = adj_cells.reject do |cell|
      cell[1].to_i < 1 || cell[1].to_i > 4 || cell[0].ord < 65 || cell[0].ord > 68
    end
  end





end
