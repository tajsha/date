class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.integer :gender
      t.integer :age
      t.string :zip_code
      t.integer :children
      t.integer :religion
      t.integer :ethnicity

      t.timestamps
    end
  end
end
