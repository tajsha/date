class ChangeRecipientdeletedFormatInMyTable < ActiveRecord::Migration
    def self.up
      change_column :messages, :recipient_deleted, :boolean
    end

    def self.down
      change_column :messages, :recipient_deleted, :integer
    end
  end