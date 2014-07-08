class PaymentNotificationsController < ApplicationController

def index
  
  redirect_to root_url
end

   def create
     PaymentNotification.create!(:params => params, :status => params[:payment_status], :transaction_id => params[:txn_id])
     render :nothing => true
   end
 end