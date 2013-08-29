class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource
  has_many   :votes
  
  validates :content, presence: true #length: { maximum: 1000, minimum: 100 }
  validates :title, presence: true #length: { maximum: 100, minimum: 10 }
  validates_numericality_of :score, :on => :create, :only_integer => true,
  :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5

  def upvotes
    votes.where(kind: "up")
  end

  def downvotes
    votes.where(kind: "down")
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      review = Review.find_or_create_by(user_id: row["user_id"], resource_id: row["resource_id"] )
      review.update_attributes!(row.to_hash)
    end
  end
end
