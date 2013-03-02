class AddReligionImportanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :religion_importance, :string
  end
end
