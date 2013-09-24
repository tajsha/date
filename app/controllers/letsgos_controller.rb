class LetsgosController < ApplicationController
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


private

def letsgo_params
  params.require(:letsgo).permit(:content)
end
end