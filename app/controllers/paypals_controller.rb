class PayPalsController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @paypal = PaypalInterface.new(@order)
    @paypal.express_checkout
    if @paypal.express_checkout_response.success?
      @paypal_url = @paypal.api.express_checkout_url(@paypal.express_checkout_response)
    else
      # manage error
    end
  end