API_Key = 'caayc7ber87wydmp69akr57c'

# App Requirements:
#

# 20 questions - how well can you guess the tomatometer for these films (dont cheat and look online)

# get 20 random movies from api, add data to array of films
# => query api for 20 random movie ids 
# => page limit set to 1 per request (5 total)
# => pull out data: 
#  			- ratings.critics_score
#  			- title
# 			- links.alternate

# ask player to guess what the rating was for the film, mulitple choice
# => create range of possible answers:
# 			- take real response and create range of possible integers, then create 4 random integer answers in addition to the correct response
# => get user response
# => compare to actual response.

# once 20 films have been guessed display score to player along with results and links to those movies

# ask if player wants to try again


# architecture breakdown:
#
# Game Class - main game class that manages game aspects:
# => command prompt and actions
# => keep track of score
# => manages all other objects
#
# Movie Class - handles api calls and stores all movie related info
# => api calls for movie info
# => stores array of 20 movies