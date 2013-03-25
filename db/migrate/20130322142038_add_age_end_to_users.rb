class AddAgeEndToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age_end, :string
  end
end
