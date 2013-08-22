class User < ActiveRecord::Base

  has_many :reviews
  has_many :votes
  has_many :interests
  has_many :interesting_resources, through: :interests, source: :resource  

	before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i	
	validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
	validates :password, length: { minimum: 6 }
	has_secure_password


  def vote!(review_id, kind)
    @review = Review.find(review_id)
    if is_different_user?(@review.user)
      if has_voted?(@review)
        votes.find_by(review_id: @review.id).update_attribute(:kind, kind)
      else
        votes.create!(review_id: @review.id, kind: kind)
      end
    end
  end

  def is_different_user?(user)
    self != user
  end

  def has_voted?(review)
    return true if votes.find_by(review_id: review.id)
  end

  def has_upvoted?(review)
    return true if votes.find_by(review_id: review.id, kind: "up")
  end

  def has_downvoted?(review)
    return true if votes.find_by(review_id: review.id, kind: "down")
  end

  def interested!(resource)
    interests.create!(resource_id: resource.id) unless interested?(resource)
  end

  def not_interested!(resource)
    @interest = interests.find_by(resource.id)
    @interest.destroy! if @interest
  end

  def interested?(resource)
    return true if interests.find_by(resource_id: resource.id)
  end
end
