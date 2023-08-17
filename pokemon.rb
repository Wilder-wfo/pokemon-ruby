require_relative "pokedex/pokemons"

class Pokemon
  attr_reader :species, :moves, :speed, :individual_stats, :type, :base_experience, :experience
  attr_accessor :current_move, :level
  def initialize(name, species)
    @name = name
    poke_details = Pokedex::POKEMONS[species]
    @species = species
    @type = poke_details[:type]
    @level = 1
    @experience = 0
    @base_experience = poke_details[:base_exp]
    @especific_growth_rate = poke_details[:growth_rate]    
    @base_stats = poke_details[:base_stats] # e.g. "Ratata" => {...., base_stats: { hp: 30, attack: 56, ...pokemon's stats... , speed: 72 },    
    @effort_points = poke_details[:effort_points] # e.g. "Ratata" => {..., effort_points: { type: :speed, amount: 1 }, ...}
    @max_health = poke_details[:base_stats][:hp]
    @speed = poke_details[:base_stats][:speed]    
    @moves = poke_details[:moves] # e.g. "Ratata" => {..., moves: ["tackle", "quick attack"], ...} 
    @health = nil
    @current_move = nil    
    @individual_stats = { hp: rand(0..31), attack: rand(0..31), defense: rand(0..31),
      special_attack: rand(0..31), special_defense: rand(0..31), speed: rand(0..31) }
    @effort_values = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 }
  end

  def increase_experience(loser)
      @experience += (Pokedex::POKEMONS[loser.species][:base_exp] * loser.level / 7.0).floor
  end

  def prepare_for_battle
    @health = @max_health
    @current_move = nil
  end

  def receive_damage(damage)
    @health -= damage
  end

  def fainted?
    !@health.positive?
  end
  
  def attack(other)
    hits = @current_move[:accuracy] >= rand(1..100)
    puts "#{@species} uses #{other.current_move[:name] } move"
    if hits
      other.receive_damage(@current_move[:power])
      puts "Hits #{other.species} and caused #{@current_move[:power]} damage"
    else
      puts "#{@species} failed to hit #{other.species} and didn't cause any damage"
    end
  end
  
  def calc_new_level
    # exp is the minimum amount of experience points to reach level n (new_level)
    exp = 0
    new_level = level + 1
    case @especific_growth_rate
      when "slow"
        exp = ((5 * new_level**3)/4).floor
      when "medium_slow"
        exp = ((6/5)*(new_level)**3 - 15*(new_level)**2 + 100*new_level - 140).floor
      when "medium_fast"
        exp = ((new_level)**3).floor
      when "fast"
        exp = ((4/5)*(new_level)**3).floor
    end
        
    @experience >= exp ? level = new_level : level
  end
end