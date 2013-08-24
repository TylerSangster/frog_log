class Interest < ActiveRecord::Base

  belongs_to :user
  belongs_to :resource

  validates :user_id, presence: true
  validates :resource_id, presence: true

end
