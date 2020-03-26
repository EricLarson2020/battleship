require "pry"

class Computer

  attr_reader :board1, :cell_list, :attack_cell, :ship1, :ship2
  def initialize(board1, board2 = false)
    @board1 = board1
    @board2 = board2
    @cell_list = @board1.cells.keys
    @attack_cell_list = @board1.cells.keys
    @place_cell_list = @board1.cells.keys
    @attack_cell = ''
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
    # binding.pry
    if !@attack_cell_list.empty?
      @attack_cell = @attack_cell_list.shuffle[0]
      index = @attack_cell_list.index(attack_cell)
      @attack_cell_list.delete_at(index)

      @attack_cell
    else
      @attack_cell = ''
    end
    @attack_cell
  end

  def smart_attack
    # binding.pry
    if @attack_cell == ''
      attack
    elsif @board2.cells[@attack_cell].status == :missed || @board2.cells[@attack_cell].status == :sunk
      puts "random attack"
      attack

    elsif @board2.cells[@attack_cell].status == :hit
      smart_cells = adjacent_cells(@attack_cell).find_all do |cell|
        @attack_cell_list.include?(cell)
      end
      # binding.pry
      if smart_cells == []
        attack
      else
        @attack_cell = smart_cells.shuffle[0]
        index = @attack_cell_list.index(@attack_cell)
        @attack_cell_list.delete_at(index)
        puts "SMART ATTACK!"
        @attack_cell
      end
    end
    # binding.pry
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
    adj_cells2 = adj_cells.reject do |cell|
      cell[1].to_i < 1 || cell[1].to_i > 4 || cell[0].ord < 65 || cell[0].ord > 68
    end
  end





end
