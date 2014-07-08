class PaymentNotification < ActiveRecord::Base
    belongs_to :ad
    serialize :params
    after_create :mark_ad_as_purchased

    def mark_ad_as_purchased
      if status == "Completed"
        ad.update_attribute(:published => true)
      end
    end
  end