require_relative "pokemon"

class Battle
  def initialize(player, bot)
    @player = player
    @bot = bot
    @player_pokemon = @player.pokemon
    @bot_pokemon = @bot.pokemon
  end

  def start
    @player_pokemon.prepare_for_battle
    @bot_pokemon.prepare_for_battle
    puts "-------------------Battle Start!-------------------"
    puts "#{@player.name}'s #{@player.pokemon.species} - Level #{@player.pokemon.level}"
    puts "HP: #{@player_pokemon.individual_stats[:hp]}"
    puts "-------------------VS-------------------"
    puts "#{@bot.name}'s #{@bot.pokemon.species} - Level #{@bot.pokemon.level}"
    puts "HP: #{@bot_pokemon.individual_stats[:hp]}"
    puts "----------------------------------------"

    battle_loop
    winner = @player_pokemon.fainted? ? @bot_pokemon : @player_pokemon
    loser = winner == @player_pokemon ? @bot_pokemon : @player_pokemon
    winner.increase_experience(loser)
    winner.calc_new_level
    puts "--------------------------------------------------"
    puts "#{loser.species} FAINTED!"
    puts "--------------------------------------------------"
    puts "Great #{winner.species} WINS!"
    puts "Great #{winner.species} gained #{winner.species} experience points"
    puts "-------------------Battle Ended!-------------------"
  end

  def attack_first(player_pokemon, bot_pokemon)
    player_move = player_pokemon.current_move
    bot_move = bot_pokemon.current_move

    if player_move[:priority] > bot_move[:priority]
      player_pokemon
    elsif player_move[:priority] < bot_move[:priority]
      bot_pokemon
    elsif player_pokemon.speed > bot_pokemon.speed
      player_pokemon
    elsif player_pokemon.speed < bot_pokemon.speed
      bot_pokemon
    else
      [player_pokemon,bot_pokemon].sample
    end
  end

  def battle_loop
    until @player_pokemon.fainted? || @bot_pokemon.fainted?  
      @player.select_move_player  # "ember"
      @bot.select_move_bot # "scratch"
      first = attack_first(@player_pokemon, @bot_pokemon)
      second = (first == @player_pokemon) ? @bot_pokemon : @player_pokemon
      puts "--------------------"
      first.attack(second)
      second.attack(first) unless second.fainted?
      puts "--------------------"
    end
  end
end
