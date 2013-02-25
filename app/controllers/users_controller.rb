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
  end
  
  def show
    @user = User.find(params[:id])
  end
  
    def edit
      @user = User.find(params[:id])
end
  
  def index
    @users = User.all
  end
  
  def destroy
     User.find(params[:id]).destroy
     flash[:success] = "User deleted."
     redirect_to users_url
   end
  
def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Account updated"
      redirect_to @user
    else
      render 'edit'
    end
end
end