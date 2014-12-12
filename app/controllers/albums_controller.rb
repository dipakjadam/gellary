class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end
  
  def index
    @albums = current_user.albums
  end

  def show
     @album = Album.find(params[:id])
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    respond_to do |format|
      format.html { redirect_to user_albums_path(current_user, @photo.album), notice: 'album was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
    
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    
   respond_to do |format|
      if @album.update_attributes(album_params)
        format.html { redirect_to  user_albums_path }
	format.js {}
      else
	format.js
	format.html { render 'edit'}
      end
    end
  end 

  def create
    @album = Album.new(album_params)
    @album.user_id = current_user.id
    
    respond_to do |format|
      if @album.save
	  format.html { redirect_to  user_albums_path }
	  format.js
      else
        format.html { render :new }
      end
    end
  end

  private
    def album_params
      params.require(:album).permit(:title, :describtion)
    end
end
