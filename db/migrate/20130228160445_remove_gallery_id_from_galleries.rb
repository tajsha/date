class RemoveGalleryIdFromGalleries < ActiveRecord::Migration
  def up
    remove_column :galleries, :gallery_id
  end

  def down
    add_column :galleries, :gallery_id, :string
  end
end
