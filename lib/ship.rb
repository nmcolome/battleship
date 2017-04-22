class Ship
  attr_reader :name,
              :size,
              :location

  def initialize(name, size)
    @name = name
    @size = size
    @location = []
  end

  def << (cell)
    location << cell
  end

end