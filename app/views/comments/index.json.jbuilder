json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :photo_id, :user_comment
  json.url comment_url(comment, format: :json)
end
