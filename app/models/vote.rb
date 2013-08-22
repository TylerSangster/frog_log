class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :user_id, presence: true
  validates :review_id, presence: true
  validates :kind, presence: true
  validates_inclusion_of :kind, :in => ["up", "down"]

end
