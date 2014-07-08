class NotificationsController < ApplicationController
  
  
  def create
            query = params
            query[:cmd] = "_notify-validate"
            if(response.body == "VERIFIED")
                Rails.logger.debug params.inspect "Notification is valid"
            end
           end
    end