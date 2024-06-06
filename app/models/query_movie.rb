class QueryMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :gpt_query
end
