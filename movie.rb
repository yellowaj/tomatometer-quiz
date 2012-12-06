require 'open-uri'
require 'json'
require_relative 'config'

class Movie

  attr_accessor :score, :title, :link, :movies

  def initialize
  	self.movies = []
    get_movies
  end

  def clear_movies
  	self.movies.clear
  end

  def get_movies
  	get_movies_by_type
  end	

  def pull_movie(number=1)
    unless movies.empty?
      movies.shift(number)
    else  
      nil
    end  
  end 

  def empty?
    movies.empty?
  end 

  private

  def get_movies_by_type(type='in_theaters')
  	begin
      movie_data = open("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/#{type}.json?apikey=#{API_KEY}").read

      movie_json = JSON.parse(movie_data, symbolize_names: true)

      movie_json[:movies].each do |movie|
        self.movies << { id: movie[:id], title: movie[:title], score: movie[:ratings][:audience_score], link: movie[:links][:alternate] }
      end  
    rescue OpenURI::HTTPError => ex
      puts "404 error"
    end
  end	   	

end