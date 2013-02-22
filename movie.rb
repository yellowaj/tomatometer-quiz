require 'open-uri'
require 'json'
require_relative 'config'

class Movie

  attr_accessor :movies

  def initialize
  	self.movies = []
    get_movies
    shuffle_movies
  end

  def clear_movies
  	self.movies.clear
  end

  def get_movies
  	get_movies_by_type('movies', 'in_theaters')
    get_movies_by_type('movies','upcoming')
    get_movies_by_type('dvds','top_rentals')
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

  def shuffle_movies
    self.movies.shuffle!
  end

  def get_movies_by_type(cat='movies', type='in_theaters', limit=10)
    url = "http://api.rottentomatoes.com/api/public/v1.0/lists/"
    url += (cat == 'dvds') ? "dvds/" : "movies/"
    url += "#{type}.json?apikey=#{API_KEY}"
    url += "&page_limit=#{limit}" if cat == 'movies'
    url += "&limit=#{limit}" if type == 'top_rentals'

  	begin
      movie_data = open(url).read

      movie_json = JSON.parse(movie_data, symbolize_names: true)

      movie_json[:movies].each do |movie|
        self.movies << { id: movie[:id], title: movie[:title], score: movie[:ratings][:audience_score], link: movie[:links][:alternate] }
      end  
    rescue OpenURI::HTTPError => ex
      puts "404 error"
    end
  end	   	

end