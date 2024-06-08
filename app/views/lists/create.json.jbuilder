if @list.persisted?
  json.form render(partial: "lists/form", formats: :html, locals: { list: List.new })
  json.inserted_item render(partial: "lists/list", formats: :html, locals: { list: @list, count_movies: @count_movies})
  json.sidebar_item render(partial: "shared/sidebar_item", formats: :html, locals: { list: @list })
else
  json.form render(partial: "lists/form", formats: :html, locals: { list: @list })
end
