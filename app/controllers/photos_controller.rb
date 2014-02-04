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



  def resize(width, height, gravity = 'Center')
    manipulate! do |img|
      img.combine_options do |cmd|
        cmd.resize "#{width}"
        if img[:width] < img[:height]
          cmd.gravity gravity
          cmd.background "rgba(255,255,255,0.0)"
          cmd.extent "#{width}x#{height}"
        end
      end
      img = yield(img) if block_given?
      img
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
  
  def avatar
    if current_user.update_attribute(:avatar_id, params[:id])
      flash[:notice] = "Successfully made Avatar."
        else
          flash[:notice] = "Avatar failed"
        end
        redirect_to(current_user)
      end
end