class Resource < ActiveRecord::Base
  
  has_many :interests
  has_many :interested_users, through: :interests, source: :user


  has_many :ratings
  has_many :rated_resources, :through => :ratings, :source => :resources

  has_many :subject_lists
  has_many :provider_lists
  has_many :format_lists

  validates :cost, :format => { :with => /\A\$?(?=\(.*\)|[^()]*$)\(?\d{1,3}(,?\d{3})?(\.\d\d?)?\)?\z/}, :numericality => {:greater_than_or_equal_to => 0}

  mount_uploader :resource_photo, ResourcePhotoUploader

  acts_as_taggable_on :subjects, :formats, :providers rescue nil

  has_many :tags, :through => :taggings

  validates :name, :subject_list, :description, :format_list, :cost, :cost_type, :provider_list, presence: true
  validates :name, :uniqueness => true
  validates :url, :presence => true, uniqueness: true, :format => /(^$)|(^((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :cost, :format => { :with => /\A\$?(?=\(.*\)|[^()]*$)\(?\d{1,3}(,?\d{3})?(\.\d\d?)?\)?\z/}, :numericality => {:greater_than_or_equal_to => 0}
  
  # scoped_search on: [:subject_list, :format_list, :provider_list]
  scoped_search :in => :tags, :on => :name
  scoped_search on: [:name, :description]
  # scoped_search :in => :subjects, :on => :name

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

  def average_score
    reviews.average(:score)
  end

  def helpful_good_reviews(n)
    helpful_reviews(n, ">=4")
  end

  def helpful_bad_reviews(n)
    helpful_reviews(n, "<=3")
  end

  def helpful_reviews(n, condition)
    reviews_with_upvotes = Hash.new(0)
    reviews.where("score#{condition}").each do |review|
      reviews_with_upvotes[review.id] = review.upvotes.count
    end
    top_review_ids = p Hash[reviews_with_upvotes.sort_by { |k,v| -v }[0..(n-1)]].keys
    review_records = Review.find(top_review_ids).group_by(&:id)
    sorted_records = top_review_ids.map { |id| review_records[id].first }
  end

  def average_rating
    @value = 0
    self.ratings.each do |rating|
        @value = @value + rating.value
    end
    @total = self.ratings.size
    @value.to_f / @total.to_f
  end
  # before_save :add_http_to_url

  # before_save :add_http_to_url

  # private

  # def add_http_to_url
  #   url.prepend('http://') unless url.match(/^(http|https)/i)
  # end
end
