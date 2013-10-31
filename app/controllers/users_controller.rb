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
    @user = User.find(params[:id]) 
     @question = Question.where(recipient_id: params[:id]).first
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
    @question = Question.where(recipient_id: params[:id])
    @letsgos = @user.letsgos.paginate(page: params[:page])
    @letsgo = current_user.letsgos.build
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
        User.find(params[:id])
      else
        current_user
      end
     @user.update_attributes(params[:user])
     respond_with @user
    end
    
    def follow
        @title = "Following"
        @user = User.find(params[:id])
      friend = User.find params[:id]
      current_user.follow! friend unless current_user.following? friend
       @users = @user.followed_users(page: params[:page])
   
      render 'show_follow'
      
    end

    def unfollow
      friend = User.find params[:id]
      current_user.unfollow! friend
      redirect_to friend
    end
    
    def choose_default_photo
      @photo = Photo.find params[:photo_id]
      current_user.default_photo = @photo
      redirect_to '/profile'
    end

     
    private
    
    
     def user_params
       params.require(:user).permit(:name, :email, :username, :password, :ethnicity, :gender, :zip_code, :birthday, :role, :age, :sexuality)
     end
end
