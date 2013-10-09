class AddBirthdayToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :birthday, :string
  end
end
