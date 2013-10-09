class AddQuestionToMessage < ActiveRecord::Migration
  def change
    add_column :questions, :message_id, :integer
  end
end
