class SubscriptionsController < ApplicationController
  
  def new
    plan = Plan.find(params[:plan_id])
    @subscription = plan.subscriptions.build
    if params[:PayerID]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
      @subscription.email = @subscription.paypal.checkout_details.email
    end
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save_with_payment
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end
  
  def paypal_checkout
    plan = Plan.find(params[:plan_id])
    subscription = plan.subscriptions.build
    redirect_to subscription.paypal.checkout_url(
      return_url: new_subscription_url(:plan_id => plan.id),
      cancel_url: root_url
    )
  end
    
    def updatesubscription
      @user = current_user
      @customer = Stripe::Customer.retrieve(@user.subscription.stripe_customer_token)
      @customer.update_subscription(:plan => "1", :prorate => true)
     current_user.save!
      flash.alert = 'Your subscription has been updated!'
      redirect_to root_url
     end

     def cancelsubscription
       @user = current_user
         @customer = Stripe::Customer.retrieve(@user.subscription.stripe_customer_token)
         @customer.cancel_subscription()
         current_user.save!
         flash.alert = 'Your subscription has been cancelled successfully!'
         redirect_to root_url
       end
       
       def showcard
         @user = current_user
         Stripe::Customer.retrieve(@user.subscription.stripe_customer_token).cards.all()
       end
       
       def changecard
           @user = current_user       
           @customer = Stripe::Customer.retrieve(@user.subscription.stripe_customer_token)

             card = @customer.cards.create({
               :card => @user.subscription.stripe_customer_token
             })

             @customer.default_card = card
             @customer.save
           end
           
           def suspend
             @user = current_user
             @user.subscription.suspend_paypal
               flash.alert = 'Billing has been suspended!'
                redirect_to root_url
           end

           def reactivate
             @user = current_user
             @user.subscription.reactivate_paypal
               flash.alert = 'Billing has been activated!'
                redirect_to root_url
           end
         
         def updatebilling
             @user = current_user
             customer = Stripe::Customer.retrieve(@user.subscription.stripe_customer_token)
             customer.cards.retrieve("#{@user.subscription.stripe_card_id}").delete()
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
end