class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, presence: true
  

  mount_uploader :picurl, PictureUploader
  validates_presence_of :picurl
  validates :picurl, presence: true
  validate  :ava_size



	


  private

    # Validates the size of an uploaded picture.
    def ava_size
      if picurl.size > 5.megabytes
        errors.add(:picurl, "should be less than 5MB")
      end
    end
end



