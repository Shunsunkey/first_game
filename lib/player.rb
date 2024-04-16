require 'pry'

class Player
    attr_accessor :name, :life_points
    @@all_player = []

    def initialize(name, life_points = 10)
        @name = name
        @life_points = life_points
        @@all_player << self
    end

    def self.all
        return @all_player
    end

    def show_state
        puts "#{@name} a #{@life_points} points de vie "
    end

    def gets_damage(damage)
        @life_points -= damage
        if @life_points <= 0
            puts "Le joueur #{@name} a été tué !"
        end
    end

    def compute_damage
        return rand(1..6)
    end

    def attacks(player)
        puts "#{@name} attaque le joueur #{player.name}"
        damage = compute_damage
        player.gets_damage(damage)
        puts "Il lui inflige #{damage} points de dégâts !"
    end
end

class HumanPlayer < Player
    attr_accessor :weapon_level

    def initialize(name, life_points = 100, weapon_level = 1)
        @name = name
        @life_points = life_points
        @weapon_level = weapon_level
    end
    def show_state
        puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
    end

    def compute_damage
        return rand(1..6) * @weapon_level
    end

    def search_weapon
        new_weapon = rand(1..6)
        puts "Tu as trouvé une arme de niveau #{new_weapon}"

        if new_weapon > @weapon_level
            @weapon_level = new_weapon
            puts "On se rapproche de l'épée maudite du saigneur guerrier !"
        else
            puts "Nah, elle vaut même pas un pet de bwork"
        end
    end

    def search_health_pack
        result = rand(1..6)
        case result
        when 1
            "Même pas une plume de piou à l'horizon"
        when 2..5
            @life_points += 50
            @life_points = 100 if @life_points> 100
            "Wouhou tu as trouvé une potion de soin ! +50HP !"
        when 6
            @life_points += 80
            @life_points = 100 if @life_points > 100
            "Waaa, la déesse Eniripsa est avec toi! +80HP !"
        end
    end
end