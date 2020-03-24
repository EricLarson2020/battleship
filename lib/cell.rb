

class Cell
  attr_reader :coordinate, :fire_upon
  attr_accessor :ship

  def initialize(coordinate, ship = nil)
    @coordinate = coordinate
    @ship = ship
    @fire_upon = false
  end

  def empty?
    ship == nil
  end

  def place_ship(cruiser)
    @ship = cruiser
  end

  def fired_upon?
    @fire_upon
  end

  def fire_upon
    @fire_upon = true
    if ship != nil
    ship.hit
    end
  end

  def render(optional = false)
    if @fire_upon == false && !optional
      "."
    elsif @fire_upon == false && optional
      "S"
    elsif @fire_upon == true && @ship == nil
      "M"
    elsif @fire_upon == true && @ship != nil && ship.health != 0
      "H"
    else
      "X"
    end

  end
end
