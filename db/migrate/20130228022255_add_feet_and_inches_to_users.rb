class AddFeetAndInchesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :feet, :integer
    add_column :users, :inches, :integer
  end
end
