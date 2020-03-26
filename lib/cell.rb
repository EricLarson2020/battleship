

class Cell
  attr_reader :coordinate, :fire_upon, :status
  attr_accessor :ship

  def initialize(coordinate, ship = nil)
    @coordinate = coordinate
    @ship = ship
    @fire_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(cruiser)
    @ship = cruiser
  end

  def fired_upon?
    @fire_upon
  end

  def fire_upon
    @fire_upon = true
    if @ship != nil
    @ship.hit
    end
  end

  def render(optional = false)
    if @fire_upon == false && !optional
      @status = "Not_hit"
      "."
    elsif @fire_upon == false && optional && !empty?
      "S"
    elsif @fire_upon == false && optional && empty?
      "."
    elsif @fire_upon == true && @ship == nil
      @status = "Missed"
      "M"
    elsif @fire_upon == true && @ship != nil && @ship.health != 0
      @status = "Hit"
      "H"
    elsif @ship != nil && @ship.health == 0
      @status = "sunk"
      "X"
    end

  end
end
