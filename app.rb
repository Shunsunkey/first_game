require_relative 'lib/game.rb'
require_relative 'lib/player.rb'

require 'bundler'
Bundler.require

puts "Deux challengers entrent en scènes ! !"
player1 = Player.new("Josiane")
puts "A ma droite ... la belle et magnifique ! #{player1.name}"

player2 = Player.new("José")
puts "A ma gauche, le terriiiiible #{player2.name}"
    while player1.life_points > 0 && player2.life_points > 0
puts "\nPour le moment, voici l'état de nos deux challengers :"
player1.show_state
player2.show_state

puts "\nPassons à la phase d'attaque !"

puts "Josiane frappe son adversaire ! Une femme qui n'a pas froid aux yeux !"
player1.attacks(player2)
        break if player2.life_points <= 0
puts "José retourne la politesse on dirait, quel gentleman !"
player2.attacks(player1)
    end

binding.pry