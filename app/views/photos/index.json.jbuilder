json.array!(@photos) do |photo|
  json.extract! photo, :id, :album_id
  json.url photo_url(photo, format: :json)
end
