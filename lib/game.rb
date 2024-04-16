require 'pry'

class Game
    attr_accessor :human_player, :enemies_in_sight, :players_left

    def initialize(player_name, players_left = 10)
        @human_player = HumanPlayer.new(player_name)
        @enemies_in_sight = []
        @players_left = players_left
    end

    def kill_player(player)
        @enemies_in_sight.delete(player)
        @players_left -= 1
    end

    
    def is_still_ongoing?
        @human_player.life_points > 0 && @players_left > 0
    end

    def new_players_in_sight
        return puts "Tous les seigneurs siths sont en vue" if @enemies_in_sight.size == @players_left
        dice_roll = rand(1..6)
        case dice_roll
        when 1
            puts "Hm... personnes n'arrive tu as de la chance"
        when 2..4
            add_new_enemy
        when 5..6
            2.times { add_new_enemy }
        end
    end

    def show_players
        puts "Voici l'état du jedi :"
        puts @human_player.show_state
        puts "Il reste #{enemies_in_sight.count} ennemi(s) à mettre au tapis !"
    end

    def menu
        puts "Quelle action veux-tu effectuer ?"
        puts "a - chercher une meilleure arme ⚔️"
        puts "s - chercher à se soigner 💊"
        puts "attaquer un joueur en vue 💥 :"
        @enemies_in_sight.each_with_index do |enemy, index|
            puts "#{index} - #{enemy.show_state}"
        end
    end

    def menu_choice(choice)
        case choice
        when 'a'
            @human_player.search_weapon
        when 's'
            @human_player.search_health_pack
        when /[0-9]/
            index = choice.to_i
            if index < @enemies_in_sight.size
              @human_player.attacks(@enemies_in_sight[index])
              kill_player(@enemies_in_sight[index]) if @enemies_in_sight[index].life_points <= 0
            else
                puts "Choix invalide !"
            end
        else
            puts "Choix invalide !"
        end
    end

    def enemies_attack
        @enemies_in_sight.each do |enemy|
            enemy.attacks(@human_player) if @human_player.life_points > 0
        end
    end

    def end_game
        puts "La partie est terminée !"
        if @human_player.life_points > 0
            puts "GG, tu es l'élu !"
        else
            puts "Losers retourne taper du piou !"
        end
    end

    private

    def add_new_enemy
        new_enemy = Player.new("joueur_#{rand(1000..9999)}")
        @enemies_in_sight << new_enemy
        @players_left += 1
        puts "Un nouveau seigneur sith en vue : #{new_enemy.name}."
    end
end