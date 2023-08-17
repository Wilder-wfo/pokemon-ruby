require_relative "pokedex/pokemons"

module GetInput
  def get_input(prompt)
    input = ""
    while input.empty?
      puts prompt
      print "> "
      input = gets.chomp
    end
    input
  end

  def get_input_options(prompt, options)
    input = ""
    until options.include?(input.strip.downcase)
      puts prompt
      print_options(options)
      print "> "
      input = gets.chomp
    end
    input.strip.downcase
  end

  def get_pokemon_choice(names)
    input = ""
    until names.include? input
      print "> "
      input = gets.chomp.capitalize
    end
    input
  end

  def get_train_choice
    choice = ""
    options = ["Fight", "Leave"]
    train_menu
    print "What do you want to do now?"
    print "> "
    until options.include? choice
      choice = gets.chomp.capitalize
    end
    choice
  end

  def print_options(options)
    options.each_with_index do |option, index|
      puts "#{index + 1}. #{option.capitalize}"
    end
  end
end
