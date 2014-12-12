class PhotosController < ApplicationController

	# GET /photos
	# GET /photos.json
	respond_to :js, :html
	def index
		@user = current_user
		@album = Album.find(params[:album_id])
		@photos = Photo.all
	end

	# GET /photos/1
	# GET /photos/1.json
	def show
	 @photo = Photo.find(params[:id]) 
	end

	# GET /photos/new
	def new
		@album = Album.find(params[:album_id])
		@photo = Photo.new
	end

	# GET /photos/1/edit
	def edit
		@album = Album.find(params[:album_id])
		@photo = Photo.find(params[:id])
	end
	
	def set_cover
		@album = Album.find(params[:album_id])
		if @album.update_attributes(:cover_id => params[:id])
			flash[:notice] = 'Photo has been set as a cover photo'
			redirect_to user_albums_path
		else
			
		end
	end

	# POST /photos
	# POST /photos.json
	
	def create
		@photo = Photo.new(photo_params)
		@album = Album.find(params[:album_id])
		respond_to do |format|
			if @photo.save
				format.html { redirect_to  user_album_path(current_user, @photo.album), notice: 'Photo was successfully created.' }
				format.js   { }
			else
				format.html { render :new, :user_id => current_user.id, :album_id => @album.id }
			end
		end
	end

	# PATCH/PUT /photos/1
	# PATCH/PUT /photos/1.json
	def update
		@photo = Photo.find(params[:id])
		@album = Album.find(params[:album_id])
		respond_to do |format|
			if @photo.update(photo_params)
				format.html { redirect_to  user_album_path(current_user, @photo.album) }
				#format.json { render :show, status: :ok, location: @photo }
				format.js { }
			else
				format.html { render :edit }
				format.json { render json: @photo.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /photos/1
	# DELETE /photos/1.json
	
	def destroy
		@photo = Photo.find(params[:id])
		@photo.destroy
		album= @photo.album 
		if album.cover_id == @photo.id
			album.update_attributes(:cover_id => nil)
		end
		
		respond_to do |format|
			format.html { redirect_to user_album_path(current_user, @photo.album), notice: 'Photo was successfully destroyed.' }
			format.json { head :no_content }
			format.js   { render :layout => false }
		end
	end




	private
	# Never trust parameters from the scary internet, only allow the white list through.
	def photo_params
		params.require(:photo).permit(:album_id, :avatar)
	end
end
