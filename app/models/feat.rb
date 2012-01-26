class Feat < ActiveRecord::Base
  uniquify :permalink, :chars => 0..9
  attr_reader :tag_tokens

  has_and_belongs_to_many :challenges
  has_many :checkins
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings


  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true

  # sort by most popular, newest, points, name
  scope :sort_by_popular, order('checkin_count DESC')
  scope :sort_by_newest, order('created_at DESC')
  scope :sort_by_points, order('bonus_points DESC')
  scope :sort_by_name, order('name DESC')

  # latest checkins
  def latest_checkins
     self.checkins.latest
  end

  # epic checkins
  def epic_checkins
    self.checkins.epic
  end

  def add_counts
    self.checkin_count = self.checkin_count + 1
    self.save
  end

  def tag_tokens=(ids)
    self.tag_ids = ids.split(",")
  end

  def to_param
    permalink
  end
end
