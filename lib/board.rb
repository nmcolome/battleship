class Board
  attr_reader :size,
              :value,
              :grid

  def initialize(size, value = " ")
    @size = size
    @value = value
    @grid = Array.new(size) { Array.new(size, value)}
  end
end