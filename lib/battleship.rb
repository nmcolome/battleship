require './lib/messages.rb'

# class Battleship
  include Messages

  puts welcome
  action = gets.chomp

  if action == "p" || action == "play"
    level
    action = gets.chomp
  elsif action == "i" || action == "instructions"
    instructions
    puts "press ENTER to return"
    action = gets
    puts welcome
    action = gets.chomp
  else action == "q" || action == "quit"
    quit
  end
  
# end