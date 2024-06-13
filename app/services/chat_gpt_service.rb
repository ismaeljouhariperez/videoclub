require 'openai'

class ChatGptService
  def initialize
    @client = OpenAI::Client.new
  end

  def get_recommendations(gpt_query)

  @common_prompt = "Find 20 movies that align closely with informations you found, and match actors, directors, or genres.
  Don't recommend movies that don't have OMDB posters.
  Find the IMDB ID of each movies.
  Strictly remove ids that are in this list : #{gpt_query.associated_movies}.
  Select the 4 movies with the highest IMDb ratings.
  Write a enthusiast recommendations of 40 words for each movie
  Give a title of 3-4 words for each recommendations.
  And provide the following structure:
  \n
  {\"imdb_id\": \"IMDB_ID\",
  \"title\": \"Recommendation Title in 3 Words\",
  \"description\": \"Description in 50 Words which explain the recommendation according to my query, quoting actors and director.\"}
  \n
  Example response format:
  \n
  [
  {\"imdb_id\": \"tt1375666\",
  \"title\": \"Saturday's movie\",
  \"description\": \"You'll love this, a thief who steals corporate secrets through the use of dream-sharing technology  so you'll probably like this one too\"},
  \n
  {\"imdb_id\": \"tt0477348\",
  \"title\": \"Another Coen Brothers Movie\",
  \"description\": \"Asking for a movie of Ethan and Joel Coen ? This one is rated 8.7/10, and Matt Damon is playing in it\"}
  \n
  {\"imdb_id\": \"tt0081505\",
  \"title\": \"Scary night with clowns\",
  \"description\": \"Asked for an horror movie ? Are you be prepared to crunch your friends' arms with nails\"}
  \n
  {\"imdb_id\": \"tt0345950\",
  \"title\": \"Spongebob adventures\",
  \"description\": \"Let's go for an adventure with Bob and his best friend Patrick. I guarantee you'll find back your child heart!\"}
  ]"
    if gpt_query.query.include?("favorites")
      prompt = "You are MoviesGPT, a film enthusiast and expert recommender.
      Here are the IMDb IDs of movies I liked: #{gpt_query.associated_movies}.
      Extract from IMDB database for each movies: movie name, actors, genre, or any other relevant information. "

      prompt = prompt + @common_prompt

    else
      prompt = "You are MoviesGPT, a film enthusiast and expert recommender.
      Analyze my query: #{gpt_query.query}.
      Check if my query contains movie name, actors, genre, or any other relevant information. "

      prompt = prompt + @common_prompt

    end


    chatgpt_response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        temperature: 0.3,
        messages: [
          { role: "user", content: base_content }
        ]
      }
    )
    chatgpt_response.dig("choices", 0, "message", "content")
  rescue StandardError => e
    Rails.logger.error("Failed to fetch recommendations: #{e.message}")
    []
  end
end
