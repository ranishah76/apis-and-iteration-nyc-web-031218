require 'rest-client'
require 'json'
require 'pry'


def get_character_movies_from_api(user_input)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
    character_hash = JSON.parse(all_characters)
     character = character_hash["results"].find { |hash| hash["name"].downcase == user_input}
     lucky = character["films"]
     film_info =  lucky.map {|urls| JSON.parse(RestClient.get(urls))}
end
 #iterate over the character hash to find the collection of `films` for the given
  # `character`
 #collect those film API urls, make a web request to each URL to get the info
  #for that film
 #return value of this method should be collection of info about each film.
  #i.e. an array of hashes in which each hash reps a given film
 #this collection will be the argument given to `parse_character_movies`
  #and that method will do some nice presentation stuff: puts out a list
  #of movies by title. play around with puts out other info about a given film.

def parse_character_movies(films_hash)
  #some iteration magic and puts out the movies in a nice list
   films_hash.each do |film|
     puts "Title: #{film["title"]}"
 end
end



def show_character_movies(character)
 films_hash = get_character_movies_from_api(character)
 parse_character_movies(films_hash)
 end

# BONUS

#that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

 def get_character_movie_info_from_api(user_input)
   all_movies = RestClient.get('http://www.swapi.co/api/films/')
   film_hash_1 = JSON.parse(all_movies)

    film = film_hash_1["results"].find { |hash| hash["title"].downcase == user_input}

    film_info = film["opening_crawl"]
    puts film_info

end
