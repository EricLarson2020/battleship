require 'pry'
require './lib/cell'
class Board

  attr_reader :cells
# row0 = []
# 7.times do row << Cell.new
# Board.new()
#
#   def initialize(row0)
#     #array index
#     #hash no-index
#     # [{"A1"=>"Cell.new(A1)", }]
#     board = [
#       row0,
#       [Cell, Cell,Cell,Cell],
#       [Cell, Cell,Cell,Cell],
#       [Cell, Cell,Cell,Cell],
#     ]
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

  # def cells
  #    @cells
  #
  # end

  def valid_coordinate?(cell_key)
    cells.keys.include?(cell_key)
  end

  def x_coordinates_sequential?(coordinates)
    #test if sequential in x direction
    #the first element of the coord "A" must be cosntant
    x_condition1 = coordinates.all? do |coord|
      coord[0] == coordinates[0][0]
    end
    #start at -1 for index = 0
    #the 2nd element must be incrementing
    index = -1
    x_condition2 = coordinates.all? do |coord|
      index += 1
      coord[1].to_i == coordinates[0][1].to_i + index
    end
    #decending
    index = -1
    x_condition3 = coordinates.all? do |coord|
      index += 1
      coord[1].to_i == coordinates[0][1].to_i - index
    end

    x_condition1 && (x_condition2 || x_condition3)

  end

  def y_coordinates_sequential?(coordinates)
    #the second element of the string coord "1" must be constant
    y_condition1 = coordinates.all? do |coord|
      coord[1] == coordinates[0][1]
    end
    #the first element of the string coord "A" must be incrementing
    index = -1
    y_condition2 = coordinates.all? do |coord|
      index += 1
      coord[0].ord == coordinates[0][0].ord + index
    end
    #decending
    index = -1
    y_condition3 = coordinates.all? do |coord|
      index += 1
      coord[0].ord == coordinates[0][0].ord - index
    end

    y_condition1 && (y_condition2 || y_condition3)
  end

  def ships_overlap?(ship, coordinates)

    full_cells = cells.select do |coord|
      cells[coord].ship != nil
    end

    full_cells.any? do |key, value|
    full_cell_coordinate = value.coordinate

    coordinates.include?(full_cell_coordinate)

  end




    # select do |coord|
    # #   cells.coord != nil
    # #   # require "pry";binding.pry
    # # end

  end

  def valid_placement?(ship, coordinates)
    #binding.pry
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
