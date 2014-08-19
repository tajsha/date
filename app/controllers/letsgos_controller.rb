class LetsgosController < ApplicationController
  before_action :correct_user, only: :destroy
  #load_and_authorize_resource
  def create
    @letsgo = current_user.letsgos.build(letsgo_params)
    if @letsgo.save
      flash[:success] = "Date posted!"
      redirect_to :back
else
      flash[:error] = "Date was not posted!"
      redirect_to :back
end
end

def show
  @letsgo = Letsgo.find(params[:id])
  authorize! :read, @letsgo
  
end
  
  def destroy
    @letsgo.destroy
    redirect_to root_url
  end
  
  def index
    @letsgos = Letsgo.where("repost_from_user_id IS NULL").all 
  end

def eatdrink
  @eatdrink = Letsgo.where(:tag => 'Eat/Drink').where("repost_from_user_id IS NULL")
end

def listenwatch
  @listenwatch = Letsgo.where(:tag => 'Listen/Watch').where("repost_from_user_id IS NULL")
end

def play
  @play = Letsgo.where(:tag => 'Play').where("repost_from_user_id IS NULL")
end

def explore
  @explore = Letsgo.where(:tag => 'Explore').where("repost_from_user_id IS NULL")
end

def other
  @other = Letsgo.where(:tag => 'Other').where("repost_from_user_id IS NULL")
end

def repost
  @letsgo = Letsgo.find(params[:id]).repost(current_user)
    redirect_to root_url
  end
  
  def random
    @letsgo = Letsgo.random.first
    if request.xhr?      
    end
  end
  
  def interested
    @letsgo = Letsgo.find(params[:id])
    @content = @letsgo.content
    @recipient = @letsgo.user
    @receipt = current_user.send_message(@recipient, @content, "Someone is Interested in your date!")
    redirect_to :back, notice: "Your message was sent"
  end

private

def letsgo_params
  params.require(:letsgo).permit(:content, :tag)
end

def correct_user
  @letsgo = current_user.letsgos.find_by(id: params[:id])
  redirect_to root_url if @letsgo.nil?
end
end