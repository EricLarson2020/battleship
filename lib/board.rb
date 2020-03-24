require 'pry'
class Board

  def initialize
    @x_size = 4
    @y_size = 4
  end

  def cells
    @cells = {"A1" => "cell",
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


end #final
