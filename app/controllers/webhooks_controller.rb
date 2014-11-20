class WebhooksController < ApplicationController
  
	skip_before_filter :verify_authenticity_token
	
	def subscription_event
		user = 	Subscription.find_by(stripe_customer_token: params[:data][:object][:customer])
		if user.present?
			user.update_column("cancelled","1")
		end
		render :nothing => true, :status => 200, :content_type => 'text/html' 
	end
end