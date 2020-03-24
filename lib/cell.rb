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
    ship.hit
  end

  def render
    @fire_upon == false
    "."
  end
end
