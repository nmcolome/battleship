class Ship
  attr_reader :name,
              :size,
              :location

  def initialize(name)
    @name = name
    @size = sizes[name]
    @location = []
  end

  def << (cell)
    location << cell
  end

  def reset
    @location = []
  end

  def sizes
    {
      "Destroyer" => 2,
      "Submarine" => 3,
      "Battleship" => 4,
      "Carrier" => 5
    }
  end

end