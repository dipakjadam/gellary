class ShareAlbumsController < ApplicationController
  def new
    @users = User.all
    @sharealbum = ShareAlbum.new
  end

  def create
  
    @sharealbum = ShareAlbum.new(:user_id => params[:share_album]["user_id"].to_i, :album_id => params[:album_id])
    respond_to do |format|
      if @sharealbum.save
        format.html { redirect_to user_albums_path(current_user) }
        format.json { render :show, status: :created, location: @album }
	end
    end
  end

end
