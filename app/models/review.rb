class Review < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true, length: { maximum: 1000, minimum: 100 }
  validates :title, presence: true, length: { maximum: 100, minimum: 10 }
  validates_numericality_of :score, :on => :create, :only_integer => true,
  :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5
end
