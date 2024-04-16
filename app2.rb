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
human_player = HumanPlayer.new(player_name)

puts "Entrée des ennemis de #{player_name}"
player1 = Player.new("Josiane")
player2 = Player.new("José")
enemies = [player1, player2]

def menu(player1, player2)
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme ⚔️"
    puts "s - chercher à se soigner 💊"
    puts "attaquer un joueur en vue 💥 :"
    puts "0 - Josiane a #{player1.life_points} points de vie"
    puts "1 - José a #{player2.life_points} points de vie"
    puts "F - Fuite"
end

def option_choice(option, human_player, player1,player2)
    case option
    when 'a'
        puts "A l'aventure compagnon ! Nouvelle arme nous voilà !"
        human_player.search_weapon
    when 's'
        puts "Allons nous faire soigner !"
        human_player.search_health_pack
    when '0'
        puts "Allons taper Josiane ! mwaha !"
        human_player.attacks(player1)
    when '1'
        puts "Allons taper José ! Héhé !"
        human_player.attacks(player2)
    when 'F'
        puts "Tu fuis lâche !"
        return false
    else
        puts "C'est quoi ce choix ? J'connais pas ! Recommence !"
    end
    return true
end

while human_player.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
    puts "\nHey pour le moment voici tes points de vie actuel :"
    human_player.show_state
    menu(player1, player2)
    print "⏳ Choisis une option :"
    choix = gets.chomp
    break unless option_choice(choix, human_player, player1, player2)
    
    puts "\nMaintenant, à eux de taper !"
    enemies.each do |enemy|
        if enemy.life_points > 0
            enemy.attacks(human_player)
            break if human_player.life_points <= 0
        end
    end
end

puts "La partie est finie"
if human_player.life_points > 0
    puts "Hey ! Tu as réussi un 1vs2 Gj !"
else
    puts "Losers ! Retourne taper des pious !"
end

binding.pry