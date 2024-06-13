require 'openai'

class ChatGptService

  TIMEOUT_SECONDS = 15  # Set the timeout duration as needed

  def initialize
    @client = OpenAI::Client.new
  end

  def get_recommendations(gpt_query)
    @common_prompt = "Find 5 movies that align closely with informations you found, and match actors, directors, or genres.
    Don't recommend movies that don't have OMDB posters.
    Find the IMDB ID of each movies.
    Select the 4 movies with the highest IMDb ratings.
    Write a enthusiast recommendations of 35 words for each movie, you can make reference to the actors, directors, or genres of my query or favorite movies.
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
    \"description\": \"You'll love this, a thief who steals corporate secrets through the use of dream-sharing technology so you'll probably like this one too\"},
    \n
    {\"imdb_id\": \"tt0477348\",
    \"title\": \"Another Coen Brothers Movie\",
    \"description\": \"Asking for a movie of Ethan and Joel Coen? This one is rated 8.7/10, and Matt Damon is playing in it\"}
    \n
    {\"imdb_id\": \"tt0081505\",
    \"title\": \"Scary night with clowns\",
    \"description\": \"Asked for a horror movie? Are you prepared to crunch your friends' arms with nails\"}
    \n
    {\"imdb_id\": \"tt0345950\",
    \"title\": \"Spongebob adventures\",
    \"description\": \"Let's go for an adventure with Bob and his best friend Patrick. I guarantee you'll find back your child heart!\"}
    ]"

    if gpt_query.query.include?("favorites")
      prompt = "You are MoviesGPT, a film enthusiast and expert recommender.
      Here are the IMDb IDs of movies I liked: #{gpt_query.associated_movies}.
      Extract from IMDB database for each movie: movie name, actors, genre, or any other relevant information. "
      prompt += @common_prompt
    else
      prompt = "You are MoviesGPT, a film enthusiast and expert recommender.
      Analyze my query: #{gpt_query.query}.
      Check if my query contains movie name, actors, genre, or any other relevant information. "
      prompt += @common_prompt
    end

    chatgpt_response = @client.chat(
      parameters: {
        model: "gpt-4",
        temperature: 0.5,
        messages: [
          { role: "user", content: prompt }
        ]
      }
    )
    chatgpt_response.dig("choices", 0, "message", "content")

  rescue Timeout::Error
    Rails.logger.error("API call timed out.")
    fallback_response

  rescue StandardError => e
    Rails.logger.error("Failed to fetch recommendations: #{e.message}")
    fallback_response
  end
end

private

def fallback_response
  '[
    {"imdb_id": "tt22053876",
    "title": "What was before the Big Bang?",
    "description": "Our AI couldn\'t answer on time..."}
  ]'
end
