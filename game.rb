require_relative 'movie.rb'

class Game

  @@exit_commands = ['quit', 'exit']

  def initialize
  	@movie = Movie.new
  end

  def launch
  	start_game
    until quit_game
      print '> '
      @prompt = get_prompt
      play_game
      break if game_ends
    end
  end

  def start_game
  	print_message('the great tomatometer quiz game!')
  	print_message('20 questions to test your film critic prowess...', nil)
  	print_message('How well do you know the tomatometer score for current, past and upcoming movies?', nil)
  	print_message('20 multiple choice questions. Guess the correct tomatometer score for each film (don\'t cheat online!)', nil)
  	print_message('good luck!', nil)
  end

  def play_game
  	puts 'game started...'
  end

  private 

  def get_prompt
  	gets.chomp.downcase
  end

  def print_message(msg, type='header')
  	if type == 'header'
  	  puts "-------- #{msg.capitalize} --------\n\n"
  	else
  	  puts "#{msg.capitalize}\n\n"
  	end  
  end

  def quit_game
  	@@exit_commands.include?(@prompt)
  end

  def game_ends
  	@movie.empty?
  end	

end

game = Game.new.launch