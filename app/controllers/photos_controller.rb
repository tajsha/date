class PhotosController < ApplicationController
 load_and_authorize_resource
 
  def new
    @photo = Photo.new(:gallery_id => params[:gallery_id])
  end
  
  def create
    if @photo.save
      flash[:notice] = "Successfully created photos."
      redirect_to @photo.gallery
    else
      render :action => 'new'
    end
end

  def edit
  end
  
  def update
    if @photo.update_attributes(paramas[:photo])
      flash[:notice] = "Successfully updated photo."
      redirect_to @photo.gallery
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @photo.destroy
    flash[:notice] = "Successfully destroyed photo."
    redirect_to @photo.gallery
  end
end