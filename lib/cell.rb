class Cell
  attr_reader :coordinate, :ship, :fire_upon

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

  def render
    if @fire_upon == false
      "."
    elsif @fire_upon == true && @ship == nil
      "M"
    elsif @fire_upon == true && @ship != nil && ship.health != 0
      "H"
    else 
      "X"
    end
  end
end
