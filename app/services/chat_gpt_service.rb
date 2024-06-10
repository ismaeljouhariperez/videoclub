require 'openai'

class ChatGptService
  def initialize
    @client = OpenAI::Client.new
  end

  def get_recommendations(gpt_query)
    # Base content for the message
    base_content = "You are MoviesGPT, a film enthusiast and expert recommender.
    Analyze my query: #{gpt_query.query}.
    To guide you, here are the IMDb IDs of movies I liked: #{gpt_query.associated_movies}.
    Recommend 4 movies that align mostly with my query, and then inspired by movies I liked.
    Don't recommend movie that don't have OMDB poster.
    Order the recommendations by the most relevant to the least relevant.
    For each movie, provide the following structure:
    \n
    {\"imdb_id\": \"IMDB_ID\",
    \"title\": \"Recommendation Title in 3 Words\",
    \"description\": \"Description in 30 Words\"}
    \n
    Example response format:
    \n
    [
    {\"imdb_id\": \"tt0114369\",
    \"title\": \"Saturday's movie\",
    \"description\": \"Matrix and Interstellar are in you favorites, so you'll probably like this one too\"},
    \n
    {\"imdb_id\": \"tt0477348\",
    \"title\": \"Another Coen Brothers Movie\",
    \"description\": \"It seems you liked a movie of Ethan and Joel Coen, this one is rated 8.7/10, and Matt Damon is playing in it\"}
     \n
    {\"imdb_id\": \"tt0081505\",
    \"title\": \"Scary night with clowns\",
    \"description\": \"I didn't find any horro movie in your favorites, so be prepared to crunch you friends arms with nails\"}
     \n
    {\"imdb_id\": \"tt0345950\",
    \"title\": \"Spongebob adventures\",
    \"description\": \"Let's go for an adventure with Bob and his best friend Patrick. I guarantee you'll find back your child heart!\"}
    ]"

    # Append optional query if present
    # if gpt_query.query.present?
    #   base_content +=
    #   "\n\n Recommend movies based on this request: #{gpt_query.query} and my favorite movies."
    # end

    chatgpt_response = @client.chat(
      parameters: {
        model: "gpt-4-turbo",
        temperature: 0.7,
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
