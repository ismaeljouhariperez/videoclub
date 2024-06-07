class ChatGptService
  def initialize
    @client = OpenAI::Client.new
  end

  def get_imdb_ids(query)
    chatgpt_response = @client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: "You are MoviesGPT, a film enthusiast and expert recommender. Please analyze the following user query: '#{query}'.
      1. Identify key elements such as genre preferences, mentioned actors or directors, mood or themes, and any specific titles or time periods referenced.
      2. Based on the identified elements, recommend 5 IMDb IDs of movies that align with the user's interests."
      }]})

    chatgpt_response["choices"][0]["message"]["content"].scan(/tt\d{7}/)
  end
end
