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
    @letsgos = Letsgo.all 
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