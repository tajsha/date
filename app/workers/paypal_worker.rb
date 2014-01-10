class PaypalWorker
  include Sidekiq::Worker

  def perform(order_id)
    @order = Order.find(order_id)

    @paypal = PaypalInterface.new(@order)
    @paypal.do_express_checkout
  end
end