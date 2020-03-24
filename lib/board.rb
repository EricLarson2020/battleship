require 'pry'
require './lib/ship'
require './lib/cell'
class Board

  attr_accessor :cells

  def initialize
  end

  def cells
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

  def valid_placement?(ship, coordinates)
    condition1 = coordinates.all? do |coord|
      valid_coordinate?(coord)
    end
    condition2 = y_coordinates_sequential?(coordinates) || x_coordinates_sequential?(coordinates)
    condition3 = coordinates.length == ship.length
    condition1 && condition2 && condition3
  end

  def render

  end




end #final
