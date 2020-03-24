require 'pry'
require './lib/ship'
class Board

  def initialize
    @x_size = 4
    @y_size = 4
  end

  def cells
    cells = {"A1" => "cell",
              "A2" => "cell",
              "A3" => "cell",
              "A4" => "cell",
              "B1" => "cell",
              "B2" => "cell",
              "B3" => "cell",
              "B4" => "cell",
              "C1" => "cell",
              "C2" => "cell",
              "C3" => "cell",
              "C4" => "cell",
              "D1" => "cell",
              "D2" => "cell",
              "D3" => "cell",
              "D4" => "cell"  }
  end

  def valid_coordinate?(cell_key)
    cells.keys.include?(cell_key)
  end

  def x_coordinates_sequential?(coordinates)
    #test if sequential in x direction
    x_condition1 = coordinates.all? do |coord|
      coord[0] == coordinates[0][0]
    end
    #start at -1 for index = 0
    #ascending
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
    a_to_1 = {"A" => 1, "B" => 2, "C" => 3, "D" => 4}

    y_condition1 = coordinates.all? do |coord|
      coord[1] == coordinates[0][1]
    end
    index = -1
    y_condition2 = coordinates.all? do |coord|
      index += 1
      a_to_1[coord[0]] == a_to_1[coordinates[0][0]] + index
    end
    index = -1
    y_condition3 = coordinates.all? do |coord|
      index += 1
      a_to_1[coord[0]] == a_to_1[coordinates[0][0]] - index
    end

    y_condition1 && (y_condition2 || y_condition3)
  end

  def valid_placement?(ship, coordinates)
    condition1 = y_coordinates_sequential?(coordinates) || x_coordinates_sequential?(coordinates)
    condition2 = coordinates.length == ship.length
    condition1 && condition2 
  end




end #final
