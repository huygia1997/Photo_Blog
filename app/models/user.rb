class User < ApplicationRecord
	before_save {email.downcase!}
	validates :name, presence: true, length: {maximum: 50}
	validates :email, presence: true, length: {maximum: 250},
										uniqueness: {case_sensitive: false}

	has_secure_password
	validates :password, presence: true, length: {minimum: 6}

	mount_uploader :ava, PictureUploader
	validate  :ava_size

  private

    # Validates the size of an uploaded picture.
    def ava_size
      if ava.size > 5.megabytes
        errors.add(:ava, "should be less than 5MB")
      end
    end


end
