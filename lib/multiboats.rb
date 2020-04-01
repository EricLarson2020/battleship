class Multiboats

  attr_reader :ships
  def initialize(loop_num)
    @loop_num = loop_num
    @ships = []
  end

  def ship_name_input
    p "Enter a ship name (string)"
    @ship_name = gets.chomp
  end

  def ship_length_input
    p "Enter #{@ship_name} length (4 or less)"
    @ship_length = gets.chomp.to_i
    until @ship_length.between?(1,4)
      p "Invalid"
      p "Enter #{@ship_name} length (4 or less)"
      @ship_length = gets.chomp.to_i
    end
  end

  def create_ship
    ship1 = Ship.new(@ship_name, @ship_length)
    @ships << ship1
  end

  def ship_loop
    @loop_num.times do
      ship_name_input
      ship_length_input
      p "#{@ship_name} of length #{@ship_length} was created"
      create_ship
    end
    p @ships
  end

end
