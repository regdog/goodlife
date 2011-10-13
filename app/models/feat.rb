class Feat < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :challenges
  has_many :checkins

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
end
