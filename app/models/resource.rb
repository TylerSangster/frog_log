class Resource < ActiveRecord::Base
  
  has_many :reviews
  has_many :interests
  has_many :interested_users, through: :interests, source: :user  

  validates :name, :subject, :description, :format, :cost, :cost_type, :provider, presence: true
  validates :cost, numericality: { :greater_than_or_equal_to => 0, only_integer: true }
  validates :name, :uniqueness => true
  
  validates :url, :presence => true, uniqueness: true, :format => /(^$)|(^((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  
  mount_uploader :resource_photo, ResourcePhotoUploader

  # before_save :add_http_to_url

  # private

  # def add_http_to_url
  #   url.prepend('http://') unless url.match(/^(http|https)/i)
  # end
end
