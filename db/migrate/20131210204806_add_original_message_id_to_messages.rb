class AddOriginalMessageIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :original_message_id, :string
  end
end
