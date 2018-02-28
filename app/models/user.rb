class User < ApplicationRecord
	has_many :microposts, dependent: :destroy
	has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
    has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower

	scope :abc, -> { joins(:microposts).group("users.id").order("count(microposts) desc", "users.name desc") }
	attr_accessor :remember_token
	before_save {email.downcase!}
	validates :name, presence: true, length: {maximum: 50}
	validates :email, presence: true, length: {maximum: 250},
										uniqueness: {case_sensitive: false}

	has_secure_password
	validates :password, presence: true, length: {minimum: 6}, allow_nil: true

	mount_uploader :ava, PictureUploader
	validate  :ava_size
	# validates_integrity_of :ava

	 # Returns the hash digest of the given string.
	  def User.digest(string)
	    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	                                                  BCrypt::Engine.cost
	    BCrypt::Password.create(string, cost: cost)
	  end

	  # Returns a random token.
	  def User.new_token
	    SecureRandom.urlsafe_base64
	  end

	  # Remembers a user in the database for use in persistent sessions.
	  def remember
	    self.remember_token = User.new_token
	    update_attribute(:remember_digest, User.digest(remember_token))
	  end

	  # Returns true if the given token matches the digest.
	  def authenticated?(remember_token)
	  	return false if remember_digest.nil?
	    BCrypt::Password.new(remember_digest).is_password?(remember_token)
	  end
	  # Forgets a user.
	def forget
	update_attribute(:remember_digest, nil)
	end
	# Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
  # Returns a user's status feed.
  # Returns a user's status feed.
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  def self.get_user(user_a_id)
  	User.find_by(:id => user_a_id)
  end

  private

    # Validates the size of an uploaded picture.
    def ava_size
      if ava.size > 5.megabytes
        errors.add(:ava, "should be less than 5MB")
      end
    end


end
