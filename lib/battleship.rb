require './lib/messages_module'

class Battleship
  include Messages

  def initialize
    welcome
    request_input
  end

  def selection(input)
    if input == "p" || input == "play"
      something
    elsif input == "i" || input == "instructions"
      read_instructions
      request_input
    elsif input == "q" || input == "quit"
      quits
    end
  end

  def request_input
    request_action
    input = gets.chomp
    selection(input)
  end
end

game = Battleship.new