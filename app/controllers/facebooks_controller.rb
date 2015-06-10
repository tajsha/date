require 'oauth'
class FacebooksController < ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    AccessToken.create(:user_id => current_user.id, :social_network => AccessToken::FACEBOOK,
                       :access_token => auth['credentials']['token'])
    flash[:notice] = "You are successfully connected to Facebook."
    redirect_to settings_user_url(current_user)
  end

end