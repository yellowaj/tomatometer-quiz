require_relative 'movie'

class Game

  @@exit_commands = ['quit', 'exit']

  def initialize
  	@movies = Movie.new
    @question_number = 1
    @answer_results = []
  end

  def launch
  	start_game
    until quit_game
      ask_question
      print "\n> "
      @answer = get_answer
      examine_answer
      update_question_number
      pause_game(0.5)
      break if game_ends
    end
  end

  def start_game
  	print_message('the great tomatometer quiz game!', :header)
  	print_message('20 questions to test your film critic prowess...')
  	print_message('How well do you know the tomatometer score for current, past and upcoming movies?')
  	print_message('Instructions: 20 multiple choice questions. Guess the correct tomatometer score for each film (don\'t cheat online!)')
    print_message('ready to start? [type "start" to begin]')
  
    print "\n> "
    until get_answer == 'start'
      print_message('come on! it\'s not that difficult to type: "start"')
      print_message('try it again...')
      print "\n> "
    end  
    print_message('here we go', :header)
  end

  def ask_question
    @current_movie = @movies.pull_movie.first
    scores = generate_possible_scores(@current_movie[:score])

    print_message("question #{@question_number}/20: What is the tomatometer score for: #{ucfirst(@current_movie[:title])}")
    puts "A) #{scores[0]}"
    puts "B) #{scores[1]}"
    puts "C) #{scores[2]}"
    puts "D) #{scores[3]}\n\n"
    puts 'enter one of the scores (number not letter) from above to answer'
  end

  def examine_answer
    if @current_movie[:score].to_i == @answer.to_i
      puts "\n---- #{'correct'.upcase}! ----"
    else
      puts "\n---- #{'incorrect'.upcase} ----"
    end  
  end  

  private 

  def get_answer
  	gets.chomp.downcase
  end

  def generate_possible_scores(score)
    [56, 78, 50, score].shuffle
  end

  def update_question_number
    @question_number += 1
  end  

  def print_message(msg, type=nil)
  	if type == :header
  	  puts "\n-------- #{msg.capitalize} --------\n\n"
  	else
  	  puts "#{msg.capitalize}\n\n"
  	end  
  end

  def pause_game(sec)
    sleep(sec)
  end  

  def quit_game
  	@@exit_commands.include?(@answer)
  end

  def game_ends
  	if @movies.empty?
      puts 'game over...'
      return true
    end 
    false 
  end	

  def ucfirst(str)
    str.sub(/^(\w)/) {|s| s.capitalize}
  end  

end

game = Game.new.launch