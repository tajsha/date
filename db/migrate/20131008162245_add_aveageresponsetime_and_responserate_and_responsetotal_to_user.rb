class AddAveageresponsetimeAndResponserateAndResponsetotalToUser < ActiveRecord::Migration
  def change
    change_column :users, :average_response_time, :integer, default: "100"
    change_column :users, :response_rate, :integer, default: "100"
    change_column :users, :response_total, :integer, default: "100"
  end
end
