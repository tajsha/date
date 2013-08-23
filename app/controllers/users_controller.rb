class UsersController < ApplicationController
  respond_to :html, :json
  
  def settings
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def profile
    @profile = User.profile
  end
  
  def create
    @user = User.new(user_params)
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
     User.find(id_params).destroy
     flash[:success] = "User deleted."
     redirect_to users_url
   end
  
def update
    @user = if current_user.has_role?(:admin)
       User.find(id_params)
     else
       current_user
     end
    @user.update_attributes(user_params)
    respond_with @user
    end
    
    def favorite
      type = params[:type]
      if type == "favorite"
        current_user.favorites << @user
        redirect_to :back, notice: 'You added #{@recipient_id} to your favorites'
      elsif type == "unfavorite"
        current_user.favorites.delete(@user)
        redirect_to :back, notice: 'You removed #{@recipient_id} from your favorites'
      end
    end
     
    private
    
    
     def user_params
       params.require(:user).permit(:name, :email, :username, :password, :gender, :zip_code, :birthday, :role)
     end
end