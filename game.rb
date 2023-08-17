require_relative "pokedex/pokemons"
require_relative "get_input"
require_relative "player"
require_relative "battle"
require_relative "menu_messages"

class Game
  include MenuMessages
  include GetInput
  def start
    welcome
    player_name = get_input("First, what is your name?")
    puts "\nRight! So your name is #{player_name.upcase}!"
    choose_pokemon(player_name)
    names = pokemon_options
    player_pokemon = get_pokemon_choice(names)
    puts "\nYou selected #{player_pokemon.upcase}. Great choice!"
    def get_pokemon_name(default_name)
      puts "Give your pokemon a name?"
      print "> "
      input = gets.chomp
      input.empty? ? default_name : input
    end
    pokemon_name = get_pokemon_name(player_pokemon)
    
    final_message(player_name, pokemon_name)
    main_menu
    player = Player.new(player_name, player_pokemon, pokemon_name)
    action = gets.chomp.downcase.capitalize
    until action == "Exit"
      case action
      when "Train"
        train(player)
        action = main_menu
        action = gets.chomp
      when "Leader"
        challenge_leader(player)
        action = main_menu
        action = gets.chomp
      when "Stats"
        show_stats(player)
        action = main_menu
        action = gets.chomp
      end
    end
    goodbye
  end

  def train(player)
    bot = Bot.new
    puts "#{player.name} challenge #{bot.name} for training"
    puts "#{bot.name} has a #{bot.pokemon.species} level #{bot.pokemon.level}"
    choice = get_train_choice
    if choice == "Fight"
      battle = Battle.new(player, bot)
      battle.start
    end
  end

  def challenge_leader(player)
    bot = Led.new
    bot.pokemon.level = 10
    puts "#{player.name} challenge #{bot.name} for a fight!"
    puts "#{bot.name} has a #{bot.pokemon.species} level #{bot.pokemon.level}"
    choice = get_train_choice
    if choice == "Fight"
      battle = Battle.new(player, bot)
      battle.start
    end
  end

  def show_stats(player)
    puts "Great #{player.name}:"
    puts "Kind: #{player.pokemon.species}"
    puts "Level: #{player.pokemon.level}"
    puts "Type: #{player.pokemon.type}"
    puts "Stats:"
    puts "HP: #{player.pokemon.individual_stats[:hp]}"
    puts "Attack: #{player.pokemon.individual_stats[:attack]}"
    puts "Defense: #{player.pokemon.individual_stats[:defense]}"
    puts "Special Attack: #{player.pokemon.individual_stats[:special_attack]}"
    puts "Special Defense: #{player.pokemon.individual_stats[:special_defense]}"
    puts "Speed: #{player.pokemon.individual_stats[:speed]}"
    puts "Experience Points: #{player.pokemon.experience}"
  end
end

puts "Inicio programa"

game = Game.new
game.start
