# require './lib/coordinates_validation'
# require './lib/shot_validation'


module UserInput
  # include CoordinatesValidation
  # include ShotValidation

  def get_ship_coordinates(ship)
    puts "Enter the starting and ending squares for the #{ship.type} (#{ship.magnitude}-units) ship:"
    input = gets.chomp.split(" ")
  end

  def get_shot
    shot = gets.chomp
  end
end