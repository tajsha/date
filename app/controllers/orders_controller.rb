class OrdersController < ApplicationController

  def paid
    if order = Order.pay(params[:token], params[:PayerID])
      # success message
    else
      # error message
    end
    redirect_to orders_path
  end
  
  def revoked
      if order = Order.cancel_payment(params)
        # set a message for the user
      end
      redirect_to orders_path
    end
  end
  
    def ipn
      if payment = Payment.find_by_transaction_id(params[:txn_id])
        payment.receive_ipn(params)
      else
        Payment.create_by_ipn(params)
      end
    end
  end
end