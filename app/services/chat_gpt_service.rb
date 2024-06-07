require 'openai'

class ChatGptService
  def initialize
    @client = OpenAI::Client.new
  end

  def get_imdb_ids(query)
    chatgpt_response = @client.chat(
      parameters: {
        model: "gpt-4-turbo",
        temperature: 0.7,
        messages: [
          { role: "user", content: "You are MoviesGPT, a film enthusiast and expert recommender.
          Analyze the user query: '#{query}' and recommend 7 movies that align with the user's interests.
          Send me only the IMDb IDs of those 7 movies" }
        ]
      }
    )

    chatgpt_response.dig("choices", 0, "message", "content").scan(/tt\d{7}/)
  rescue StandardError => e
    Rails.logger.error("Failed to fetch IMDb IDs: #{e.message}")
    []
  end
end
