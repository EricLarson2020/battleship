require 'pry'
require './lib/cell'
class Board

  attr_reader :cells

  def initialize
    @cells = {"A1" => Cell.new("A1"),
              "A2" => Cell.new("A2"),
              "A3" => Cell.new("A3"),
              "A4" => Cell.new("A4"),
              "B1" => Cell.new("B1"),
              "B2" => Cell.new("B2"),
              "B3" => Cell.new("B3"),
              "B4" => Cell.new("B4"),
              "C1" => Cell.new("C1"),
              "C2" => Cell.new("C2"),
              "C3" => Cell.new("C3"),
              "C4" => Cell.new("C4"),
              "D1" => Cell.new("D1"),
              "D2" => Cell.new("D2"),
              "D3" => Cell.new("D3"),
              "D4" => Cell.new("D4")  }
  end

  def valid_coordinate?(cell_key)
    @cells.keys.include?(cell_key)
  end

  def numbers_increment?(cell_list)
    index = -1
    cell_list.all? do |cell|
      index += 1
      cell[1].to_i == cell_list[0][1].to_i + index
    end
  end

  def numbers_decrement?(cell_list)
    index = -1
    cell_list.all? do |cell|
      index += 1
      cell[1].to_i == cell_list[0][1].to_i - index
    end
  end

  def letters_same?(cell_list)
    cell_list.all? do |cell|
      cell[0] == cell_list[0][0]
    end
  end

  def x_coordinates_sequential?(cell_list)
    letters_same?(cell_list) &&  (numbers_increment?(cell_list) || numbers_decrement?(cell_list))
  end

  def numbers_same?(cell_list)
    cell_list.all? do |cell|
      cell[1] == cell_list[0][1]
    end
  end

  def letters_incement?(cell_list)
    index = -1
     cell_list.all? do |cell|
      index += 1
      cell[0].ord == cell_list[0][0].ord + index
    end
  end

  def letters_decrement?(cell_list)
    index = -1
    cell_list.all? do |cell|
      index += 1
      cell[0].ord == cell_list[0][0].ord - index
    end
  end


  def y_coordinates_sequential?(cell_list)
    numbers_same?(cell_list) && (letters_incement?(cell_list) || letters_decrement?(cell_list))
  end

  def cells_with_ships
    @cells.select do |coord|
      @cells[coord].ship != nil
    end
  end

  def ships_overlap?(ship, cell_list)
    full_cells = @cells.select do |coord|
      @cells[coord].ship != nil
    end
    full_cells.any? do |key, value|
      full_cell_coordinate = value.coordinate
      cell_list.include?(full_cell_coordinate)
    end
  end

  def valid_placement?(ship, coordinates)
    in_board = coordinates.all? do |coord|
      valid_coordinate?(coord)
    end
    sequential = y_coordinates_sequential?(coordinates) || x_coordinates_sequential?(coordinates)
    within_ship_length = coordinates.length == ship.length
    dont_overlap = ships_overlap?(ship, coordinates)
    in_board && sequential && within_ship_length && !dont_overlap
  end

  def place(ship, coordinates)
      if valid_placement?(ship, coordinates)
        coordinates.each do |coordinate|
          cells[coordinate].place_ship(ship)
        end
      end
    #  binding.pry
    #  cells[coordinates[0]].place_ship(ship)
    #  binding.pry
  end

  def render(optional = false)

    puts board_layout = "  1 2 3 4 \n" +
    "A #{cells["A1"].render(optional)} #{cells["A2"].render(optional)} #{cells["A3"].render(optional)} #{cells["A4"].render(optional)} \n" +
    "B #{cells["B1"].render(optional)} #{cells["B2"].render(optional)} #{cells["B3"].render(optional)} #{cells["B4"].render(optional)} \n" +
    "C #{cells["C1"].render(optional)} #{cells["C2"].render(optional)} #{cells["C3"].render(optional)} #{cells["C4"].render(optional)} \n" +
    "D #{cells["D1"].render(optional)} #{cells["D2"].render(optional)} #{cells["D3"].render(optional)} #{cells["D4"].render(optional)} \n"
    board_layout
  end


end #final
