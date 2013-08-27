class User < ActiveRecord::Base

  has_secure_password

  has_many :ratings
  has_many :rated_resources, :through => :ratings, :source => :resources

  has_many :ratings
  has_many :votes
  has_many :interests
  has_many :interesting_resources, through: :interests, source: :resource  

	before_save { self.email = email.downcase }
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i	
	validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
	# validates :password, length: { minimum: 6 }, :unless => :password_resets
  validates :password, presence: true, length: { minimum: 6 }, if: :validate_password?
  validates :password_confirmation, presence: true, if: :validate_password?

  mount_uploader :avatar, AvatarUploader


  def validate_password?
    new_record? || !password.nil?
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

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

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
