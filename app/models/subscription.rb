class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :subscription
  belongs_to :user
  
  validates_presence_of :plan_id
  validates_presence_of :email
  
  attr_accessor :stripe_card_token, :paypal_payment_token
  
  def has_cancelled?
    if cancellation_date.present? && cancellation_date > (paid_on + 30)
      subscription.update_attributes(cancelled: "1")
      return true
    else
      return false
    end
  end
  
  def expires_at
    self.updated_at + plan.duration.days
  end
  
  def save_with_payment
    if valid?
      if paypal_payment_token.present?
        save_with_paypal_payment
      else
        save_with_stripe_payment
      end
    end
  end
  
  def paypal
    PaypalPayment.new(self)
  end
  
  def save_with_paypal_payment
    response = paypal.make_recurring
    self.paypal_recurring_profile_token = response.profile_id
    save!
  end

  def save_with_stripe_payment
    customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
    self.stripe_customer_token = customer.id
    self.cancellation_date = customer.subscriptions.first.current_period_end
    save!
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
  def payment_provided?
    stripe_card_token.present? || paypal_payment_token.present?
  end
  
  def suspend_paypal
    paypal.suspend
    save
  end
  
  
  def reactivate_paypal
    paypal.reactivate
    save
  end
  
  def update_card(subscriber, card_info)
  token = Stripe::Token.create(
    card: {
      number: card_info[:number],
      exp_month: card_info[:exp_month],
      exp_year: card_info[:exp_year],
      cvc: card_info[:cvc]
    }
  )
  customer = Stripe::Customer.retrieve(user.subscription.stripe_customer_token)
  card = customer.cards.create(card: token.id)
  card.save
  customer.default_card = card.id
  customer.save
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while updating card info: #{e.message}"
    errors.add :base, "#{e.message}"
    false
  end
end