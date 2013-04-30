class Photo < ActiveRecord::Base
  attr_accessible :title, :body, :gallery_id, :name, :image, :remote_image_url
  has_many :user, :through => :gallery
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  validate :quota

  private

  def quota
    return unless user
    if gallery.photos.count > 4
      errors[:base] << "Maximum photos uploaded, delete to upload more"
    end 
  end
end