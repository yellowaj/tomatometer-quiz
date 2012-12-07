require_relative 'movie'

class Game

  @@exit_commands = ['quit', 'exit']

  def initialize
  	
  end

  def launch
  	start_game
    
    @movies = Movie.new
    @question_number = 1
    @answer_results = []

    until quit_game
      ask_question
      print "\n> "
      @answer = get_answer.to_i
      examine_answer
      update_question_number
      pause_game(0.3)
      break if game_ends
    end
    puts @answer_results
    review_score
    end_of_game_review
    exit_program
  end

  def start_game
  	print_message('the great tomatometer quiz game!', :header)
  	print_message('20 questions to test your film critic prowess...')
  	print_message('How well do you know the tomatometer score for current, past and upcoming movies?')
  	print_message('Instructions: 20 multiple choice questions. Guess the correct tomatometer score for each film (don\'t cheat online!)')
    print_message('ready to start? [type "start" to begin]')
  
    answer = nil
    until answer == 'start'
      print "\n> "
      answer = get_answer
      exit_program if @@exit_commands.include?(answer)
      print_message("\ncome on! it's not that difficult to type: 'start'")
      print_message('try it again...')
    end  
    print_message("\nloading films.....")
  end

  def ask_question
    @current_movie = @movies.pull_movie.first
    scores = generate_possible_scores(@current_movie[:score])

    puts "\nQuestion #{@question_number}/20: What is the tomatometer score for: #{ucfirst(@current_movie[:title])}"
    puts "A) #{scores[0]}"
    puts "B) #{scores[1]}"
    puts "C) #{scores[2]}"
    puts "D) #{scores[3]}\n\n"
    puts 'enter one of the scores'
  end

  def examine_answer
    return nil if quit_game
    result_data = { movie: @current_movie, answer: @answer, correct_answer: @current_movie[:score], correct: false }

    if @current_movie[:score] == @answer
      # correct response message
      puts "\n---- #{'correct'.upcase}! ----"

      result_data[:correct] = true     
    else
      puts "\n---- #{'incorrect'.upcase} ----"
    end

    # add answer data to array of scores 
    @answer_results << result_data 
  end  

  def review_score
    correct = number_correct_answers
    case 
    when correct >= 18
      puts "\nGreat job! You scored an A!"
    when correct > 15 && correct <= 17
      puts "\nGood job! You scored a B"
    when correct > 11 && correct <= 14
      puts "\nNot bad. You scored a C"
    when correct > 8 && correct <= 10
      puts "\nJust OK. You scored a D" 
    when correct > 5 && correct <= 7
      puts "\nOuch! Were you trying? You scored a D"
    else
      puts "\nHoly crap! Have you ever seen a movie before? You failed!"     
    end
    puts "\nCorrect answers: #{correct}/20\n\n"
  end

  def end_of_game_review
    puts "Do you want to see all the results? commands: [yes, quit, exit]"
    until quit_game
      print "\n> "
      @answer = get_answer
      display_results if @answer == 'yes'
    end
  end

  def display_results
    i = 1
    @answer_results.each do |result|
      puts "\nQuestion #{i}/20: #{result[:movie][:title]}"
      if result[:correct]
        puts "Result: CORRECT\n\n"
      else
        puts "Result: INCORRECT"
        puts "Your answer: #{result[:answer]}"
        puts "Correct answer: #{result[:correct_answer]}\n\n"
      end  
      i += 1
    end
  end

  private 

  def get_answer
  	gets.chomp.downcase
  end

  def generate_possible_scores(score)
    scores = [score]
    3.times do
      new_score = range_rand((score-40), (score+40))
      redo if scores.include?(new_score)
      scores << new_score
    end
    scores.shuffle
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

  def number_correct_answers
    @answer_results.select { |res| res[:correct] }.size
  end

  def pause_game(sec)
    sleep(sec)
  end  

  def quit_game
  	@@exit_commands.include?(@answer)
  end

  def game_ends
  	if @movies.empty? || @question_number > 20
      puts 'game over...'
      return true
    end 
    false 
  end	

  def ucfirst(str)
    str.sub(/^(\w)/) {|s| s.capitalize}
  end  

  def range_rand(min, max)
    max = 99 if max >= 100
    min = 1 if min <= 0
    (min + rand(max - min)).abs
  end

  def exit_program
    puts "\ngoodbye!\n\n"
    exit
  end  


end

game = Game.new.launch