require_relative "pokedex/pokemons"

module MenuMessages
  def welcome
    puts "\n#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#"
    puts "#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#"
    puts "#$##$##$##$ ---        Pokemon Ruby         --- #$##$##$#$#"
    puts "#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#"
    puts "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#\n\n"
    puts "Hello there! Welcome to the world of POKEMON! My name is OAK!"
    puts "People call me the POKEMON PROF!\n\n"
    puts "This world is inhabited by creatures called POKEMON! For some"
    puts "people, POKEMON are pets. Others use them for fights. Myself..."
    puts "I study POKEMON as a profession."
  end

  def choose_pokemon(player_name)
    puts "Your very own POKEMON legend is about to unfold! A world of"
    puts "dreams and adventures with POKEMON awaits! Let's go!"
    puts "Here, #{player_name.upcase}! There are 3 POKEMON here! Haha!"
    puts "When I was young, I was a serious POKEMON trainer."
    puts "In my old age, I have only 3 left, but you can have one! Choose!\n\n"
  end

  def pokemon_options
    names_all = Pokedex::POKEMONS.select { |name, data| data[:growth_rate] == :medium_slow }
    names = names_all.keys
    names.each_with_index do |name, index|
      print "#{index+1}.- #{name}\n"
    end
  end

  def final_message(player_name, pokemon_name)
    puts "\n#{player_name.upcase}, raise your young #{pokemon_name.upcase} by making it fight!"
    puts "When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER"
  end

  def main_menu
    puts ("-" * 26) + "Menu" + ("-" * 26)
    puts
    puts "1. Stats        2. Train        3. Leader       4. Exit"
    print "> "
  end

  def train_menu
    puts ("-" * 23) + "Train Menu" + ("-" * 23)
    puts
    ["Fight", "Leave"]
    puts "1. Fight        2. Leave"
    print "> "
  end

  def goodbye 
    puts "\nThanks for playing Pokemon Ruby"
  end

end
