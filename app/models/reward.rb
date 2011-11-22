class Reward < ActiveRecord::Base
  attr_reader :tag_tokens
  #attr_accessible :address, :latitude, :longitude
  #geocoded_by :address
  #after_validation :geocode, :if => :address_changed?

  belongs_to :partner
  has_many :user_wishes
  has_many :wanted_users, :through => :user_wishes, :source => :user
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings

  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true
  scope :of_kind, lambda { |kind| { :conditions => {:kind => kind} } }

  # local rewards
  def self.local
    Reward.search :partner_tag_name_starts_with => "Local"
  end

  #premium rewards
  def self.premium
    Reward.search :partner_tag_name_starts_with => "National"
  end

  def tag_tokens=(ids)
    self.tag_ids = ids.split(",")
  end

  def address
    "#{street}, #{city}, #{state}"
  end
end
