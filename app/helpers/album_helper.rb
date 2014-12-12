module AlbumHelper
  def get_photo_url(album)
    url = "cover.jpeg"
    if album.cover_id.present?
      photo = Photo.find(album.cover_id)
      url = photo.avatar.url
    end
    return url
  end
end
