class PhotosController < ApplicationController
 
  def new 
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(params[:photo])
    @photo.user = current_user
    if @photo.save
      flash[:notice] = "Successfully created photos."
      redirect_to :back
    else
      render :action => 'new'
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end
  
  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(paramas[:photo])
      flash[:notice] = "Successfully updated photo."
      redirect_to @photo.gallery
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = "Successfully destroyed photo."
    redirect_to @photo.gallery
  end
  
  def choose_default_photo
    @photo = Photo.find params[:photo_id]
    current_user.default_photo = @photo
    redirect_to '/profile' # or wherever you wan to send them
  end
end