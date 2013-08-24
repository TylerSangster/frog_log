class Resource < ActiveRecord::Base
  
  has_many :reviews
  has_many :interests
  has_many :interested_users, through: :interests, source: :user  

  mount_uploader :resource_photo, ResourcePhotoUploader

  acts_as_taggable_on :subjects, :formats, :providers rescue nil

  validates :name, :subject, :description, :format, :cost, :cost_type, :provider, presence: true
  validates :cost, :format => { :with => /\A\$?(?=\(.*\)|[^()]*$)\(?\d{1,3}(,?\d{3})?(\.\d\d?)?\)?\z/}, :numericality => {:greater_than_or_equal_to => 0}
  validates :name, :uniqueness => true
  validates :url, :presence => true, uniqueness: true, :format => /(^$)|(^((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  
  def similar(n)
    # http://stackoverflow.com/questions/8580497/how-to-get-first-n-elements-from-hash-in-ruby
    # http://stackoverflow.com/questions/801824/clean-way-to-find-activerecord-objects-by-id-in-the-order-specified
    similar_resources = []
    interested_users.each do |user|
      user.interesting_resources.each do |resource|
        similar_resources.push(resource.id)
      end
    end
    similar_with_counts = Hash.new(0)
    similar_resources.each { |resource| similar_with_counts[resource] += 1 }
    
    top_similar_ids = p Hash[similar_with_counts.sort_by { |k,v| -v }[0..(n-1)]].keys
    similar_records = Resource.find(top_similar_ids).group_by(&:id)
    sorted_records = top_similar_ids.map { |id| similar_records[id].first }
  end

  # before_save :add_http_to_url

  # before_save :add_http_to_url

  # private

  # def add_http_to_url
  #   url.prepend('http://') unless url.match(/^(http|https)/i)
  # end
end
