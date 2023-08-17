require_relative "pokedex/pokemons"
require_relative "pokedex/moves"
require_relative "pokemon"
require_relative "get_input"

class Player
  include GetInput
  attr_reader :name, :pokemon, :pokemon_name, :pokemon_level, :species, :pokemon_type, :level

  def initialize(name, pokemon_species, pokemon_name)
    @name = name
    @pokemon = Pokemon.new(pokemon_name, pokemon_species)
  end

  def select_move_player
    move = get_input_options("Select a move to attack", @pokemon.moves)
    @pokemon.current_move = Pokedex::MOVES[move]
  end
end

# Create a class Bot that inherits from Player and override the select_move method
class Bot < Player
  attr_reader :pokemon, :name
  def initialize
    bot_pokemons = Pokedex::POKEMONS.select { |key, value| key != "Onix" }
    valid_bot_pokemons = bot_pokemons.keys   
    bot_poke = valid_bot_pokemons.sample  # e.g. "Ratata"
    bot_species = bot_pokemons[bot_poke]
    bot_name = %w[Juan Wilder Pedro Roberto].sample 
    @bot_pokemon = super(bot_name, bot_poke, bot_poke.capitalize)
  end

  def select_move_bot
    move = @bot_pokemon.moves.sample
    @bot_pokemon.current_move = Pokedex::MOVES[move]
  end  
end

# Create a class led that inherits from Player and override the select_move method
class Led < Player
  attr_reader :pokemon, :name
  def initialize
    bot_poke = "Onix"
    bot_name = bot_poke
    @bot_pokemon = super(bot_name, bot_poke, bot_poke.capitalize)
  end

  def select_move_bot
    move = @bot_pokemon.moves.sample
    @bot_pokemon.current_move = Pokedex::MOVES[move]
  end  
end