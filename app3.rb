require 'bundler'
Bundler.require

require_relative 'lib/game.rb'
require_relative 'lib/player.rb'

puts " --------------------------⚔️--------------------------"
puts "| Bienvenue sur 'ILS VEULENT TOUS MA POO' ! 🔪         |"
puts "| Le but du jeu est d'être le dernier survivant !      |"
puts " --------------------------⚔️--------------------------"

puts "\nQuel est ton prénom ?"
print "📝 ➞ "
player_name = gets.chomp

my_game = Game.new(player_name)

while my_game.is_still_ongoing?
    puts "\n#{my_game.players_left}"
    puts my_game.human_player.show_state
    my_game.new_players_in_sight
    my_game.menu
    print "⏳ Choisis une option :"
    choice = gets.chomp
    my_game.menu_choice(choice)
    puts "\n"
    my_game.enemies_attack
end

puts "\n#{my_game.end_game}"

binding.pry