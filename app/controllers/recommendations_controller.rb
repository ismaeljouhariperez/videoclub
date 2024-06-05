class RecommendationsController < ApplicationController
  def index
    @movies = Movie.all
    if params[:query].present?
      client = OpenAI::Client.new
      chaptgpt_response = client.chat(parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user",
        content: "give me ids only, withtout title, from IMDB  for the user request: #{:query}"}]
      })
      ids = chaptgpt_response["choices"][0]["message"]["content"].scan(/tt\d{7}/)
      @movies = Movie.where(imdb_id: ids)
    end
  end
end
