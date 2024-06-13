require 'openai'

class ChatGptService
  def initialize
    @client = OpenAI::Client.new
  end

  def get_recommendations(gpt_query)
    if gpt_query.query.include?("favorites")
      prompt = "You are MoviesGPT, a film enthusiast and expert recommender.
      Here are the IMDb IDs of movies I liked: #{gpt_query.associated_movies}.
      Recommend me 4 movies that align closely with my favorites, but are not in my list.
      Don't recommend movies that don't have OMDB posters
      Order the recommendations by the most relevant to the least relevant.
      Double-check if the IMDb IDs match your recommended movies, and are not in this list : #{gpt_query.associated_movies}.
      For each movie, provide the following structure:
      \n
      {\"imdb_id\": \"IMDB_ID\",
      \"title\": \"Recommendation Title in 3 Words\",
      \"description\": \"Description in 30 Words which explain the recommendation according to my query and my favorites\"}
      \n
      Example response format:
      \n
      [
      {\"imdb_id\": \"tt1375666\",
      \"title\": \"Saturday's movie\",
      \"description\": \"Matrix and Interstellar are in your favorites, so you'll probably like this one too\"},
      \n
      {\"imdb_id\": \"tt0477348\",
      \"title\": \"Another Coen Brothers Movie\",
      \"description\": \"It seems you liked a movie of Ethan and Joel Coen, this one is rated 8.7/10, and Matt Damon is playing in it\"}
      \n
      {\"imdb_id\": \"tt0081505\",
      \"title\": \"Scary night with clowns\",
      \"description\": \"Shining scared you, but with this movie it's gonna worst, so be prepared to crunch your friends' arms with nails\"}
      \n
      ]"
    else
      prompt = "You are MoviesGPT, a film enthusiast and expert recommender.
      Analyze my query: #{gpt_query.query}.
      Check if my query contains movie name, actors, genre, or any other relevant information.
      Recommend 4 movies that align closely with my query, and match actors, directors, or genres I asked.
      Don't recommend movies that don't have OMDB posters.
      Give privilege to movies with higher IMDb ratings.
      For each movie, provide the following structure:
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
    end

    chatgpt_response = @client.chat(
      parameters: {
        model: "gpt-4o",
        temperature: 0.5,
        messages: [
          { role: "user", content: prompt }
        ]
      }
    )
    chatgpt_response.dig("choices", 0, "message", "content")
  rescue StandardError => e
    Rails.logger.error("Failed to fetch recommendations: #{e.message}")
    []
  end
end
