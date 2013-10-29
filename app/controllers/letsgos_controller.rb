class LetsgosController < ApplicationController
  before_action :correct_user, only: :destroy
  def create
    @letsgo = current_user.letsgos.build(letsgo_params)
    if @letsgo.save
      flash[:success] = "Date posted!"
      redirect_to root_url
else
      flash[:error] = "Date was not posted!"
      redirect_to root_url
end
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
    @random = Letsgos.offset(rand(Letsgos.count)).first
  end
  
def interested
  @letsgo = User.find(params[:id])
  @letsgo = current_user
  @recipient = Letsgo.find(params[:id])
  @body = Letsgo.find(params[:id]).content
  
  @message = Message.create(:subject => "Someone is Interested in your date!",
                         :sender_id => @letsgo.id,
                         :recipient_id => @recipient.user.id,
                         :body => "I saw your date and I'm interested in Let's go...#{@body}"
                         )

    redirect_to letsgos_path, notice: "Your message was sent"
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