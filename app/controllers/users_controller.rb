class UsersController < ApplicationController
  respond_to :html, :json
  
  def settings
    @user = User.find(params[:id])
    render layout: 'new_application'
  end
  
  def new
    @user = User.new
    render layout: 'new_application'
  end
  
  def profile
    @profile = User.profile
    @user = User.find_by(username: params[:id])
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
    @user = User.find_by(username: params[:id])
    @question = Question.where('recipient_id = ? and answer is not null', params[:id]).page(params[:page]).per_page(3)
    # @letsgos = @user.letsgos.paginate(page: params[:page])
    @letsgo = current_user.letsgos.build unless current_user.blank? 
    respond_to do |format|
      format.html { render layout: 'new_application' }
      format.js { render partial: 'questions/questions', locals: {questions: @question} }
    end
  end
    
    def edit
      @user = User.find_by(username: params[:id])
end
  
  def index
    @user = current_user
    @search = Search.new
    @users = @user.present? ? User.where('id != ?',@user.id) : User.all
    render layout: 'new_application'    
  end
  
  def destroy
     User.find(id_params).destroy
     flash[:success] = "User deleted."
     redirect_to users_url
   end
  
def update
  @user = if current_user.has_role?(:admin)
       User.find_by(username: params[:id])
      else
        current_user
      end
     @user.update_attributes(params[:user])
     respond_with @user
    end
    
def follow
    @title = "Following"
    @user = User.find_by(username: params[:id])
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
    
def follow_popup
  @user = User.find_by(username: params[:id])
  respond_to do |format|
    format.js {}
  end
end
    
    def update_stripe_billing
      @user = current_user
      customer = Stripe::Customer.retrieve(@user.subscription.stripe_customer_token)
      customer.cards.retrieve(@user.subscription.stripe_card_id).delete()
      customer.cards.create({
            card: {
            number: params[:user][:scardnumber],
            exp_month: params[:user][:sexp_month],
            exp_year: params[:user][:sexp_year],
            cvc: params[:user][:scvc],
            name: params[:user][:sname],
            address_line1: params[:user][:sbilling_address1],
            address_line2: params[:user][:sbilling_address2],
            address_city: params[:user][:saddress_city],
            address_zip: params[:user][:saddress_zip],
            address_state: params[:user][:saddress_state],
            address_country: params[:user][:saddress_country]
            }
          })
          if customer.save!
            @user.stripe_card_id = customer.active_card.id
            @user.save!
            flash.alert = 'Billing information updated successfully!'
            redirect_to root_url
          else
            flash.alert = 'Stripe error'
            redirect_to root_url
          end
        end

    def search
      @users = ThinkingSphinx.search(params[:query])
      @search = Search.new
      render :index, layout: 'new_application'
    end
     
    private
    
    
     def user_params
       params.require(:user).permit(:name, :email, :username, :password, :ethnicity, :gender, :zip_code, :birthday, :role, :age, :sexuality, :user_sex)
     end
end
