require 'openai'

class ChatGptService
  def initialize
    @client = OpenAI::Client.new
  end

  def get_recommendations(gpt_query)
    # Base content for the message
    base_content = "Here are the IMDb IDs of movies I liked: #{gpt_query.associated_movies}.
    Recommend 4 movies that align with my interests.
    For each movie, provide the following structure:
    \n
    {\"imdb_id\": \"IMDB_ID\",
    \"title\": \"Recommendation Title in 5 Words\",
    \"description\": \"Description in 15 Words\"}
    \n
    Example response format:
    \n
    [
    {\"imdb_id\": \"tt0114369\",
    \"title\": \"Thrilling Action and Dark Tone\",
    \"description\": \"You liked Matrix and Interstellar, you'll probably like this one too\"},
    \n
    {\"imdb_id\": \"tt0477348\",
    \"title\": \"Another Coen Brothers Movie\",
    \"description\": \"It seems you liked a movie of Ethan and Joel Coen, this one is rated 8.7/10\"}
    ]"

    # Append optional query if present
    if gpt_query.query.present?
      base_content += "\n\nHere is an optional request, which will direct mainly your answer: #{gpt_query.query}"
    end

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
