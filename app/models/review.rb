class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource
  has_many   :votes
  
  validates :content, presence: true, length: { maximum: 1000, minimum: 100 }
  validates :title, presence: true, length: { maximum: 100, minimum: 10 }
  validates_numericality_of :score, :on => :create, :only_integer => true,
  :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5

  def upvotes
    votes.where(kind: "up")
  end

  def downvotes
    votes.where(kind: "down")
  end
end
