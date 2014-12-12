class CommentsController < ApplicationController
  

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  
  def show
    @photo = Photo.find(params[:photo_id])
    @comment = Comment.find(params[:id])
    @comment.user_id = current_user.id
    @album = Album.find(params[:album_id])
  end

  # GET /comments/new
  
  def new
   @album = Album.find(params[:album_id])
    @photo = Photo.find(params[:photo_id])
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @album = Album.find(params[:album_id])
    @photo = Photo.find(params[:photo_id])
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @album = Album.find(params[:album_id])

    respond_to do |format|
      if @comment.save
        format.html  {redirect_to  user_album_path(current_user, @comment.photo_id.album_id)}
        #format.html { redirect_to  user_album_photo_comment_path(current_user, @comment.photo.album, @comment.photo, @comment), notice: 'Comment was successfully created.' }
        format.js {  }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
  @comment = Comment.find(params[:id])
   @album = Album.find(params[:album_id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to user_album_photo_comment_path, notice: 'Comment was successfully updated.' }
	#format.html  {redirect_to  user_album_path(current_user,@comment.photo_id.album_id)}
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  
  def destroy
    @comment = Comment.find(params[:id])
    @photo = Photo.find(params[:photo_id])
    @album = Album.find(params[:album_id])
     @comment.destroy
      respond_to do |format|
        format.html { redirect_to  user_album_path(current_user,@comment.photo.album) }
        format.json { head :no_content }
        format.js   { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
   

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :photo_id, :user_comment)
    end
end
