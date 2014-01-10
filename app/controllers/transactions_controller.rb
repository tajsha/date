class TransactionsController < ApplicationController

  request = Paypal::Express::Request.new(
    :username   => pwz2k-facilitator_api1.hotmail.com,
    :password   => 1384963232,
    :signature  => An5ns1Kso7MWUdW4ErQKJJJ4qi4-Asss8sIUzSk7XExg2DcSoBaM5nXe
  )
  payment_request = Paypal::Payment::Request.new(
    :currency_code => :USD, # if nil, PayPal use USD as default
    :amount        => SET_YOUR_OWN,
    :items => [{
      :name => Are You Taken,
      :description => 1 Month Subscription,
      :amount => 60,
      :category => :Digital
    }]
  )
  response = request.setup(
    payment_request,
    YOUR_SUCCESS_CALBACK_URL,
    YOUR_CANCEL_CALBACK_URL,
    :no_shipping => true
  )
  response.popup_uri
  
  response = request.details(token)
  # inspect these attributes for more details
  response.payer
  response.amount
  response.ship_to
  response.payment_responses
  
  response = request.checkout!(
    token,
    payer_id,
    payment_request
  )
  # inspect this attribute for more details
  response.payment_info
  
end