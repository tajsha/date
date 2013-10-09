class AddYoungestageAndOldestageToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :youngest_age, :string
    add_column :searches, :oldest_age, :string
  end
end
