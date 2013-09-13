class AddIndexToZipsCode < ActiveRecord::Migration
  def change
    add_index :zips, :code, unique: true
  end
end