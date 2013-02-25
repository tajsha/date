class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
    
    def edit
      @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:user])
    if @user.update_attributes(params[:user])
      flash[:success] = "Account updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
  end
end
end
end