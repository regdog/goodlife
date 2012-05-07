class Feat < ActiveRecord::Base
  acts_as_shareable
  acts_as_taggable_on :categories

  has_and_belongs_to_many :challenges
  has_many :checkins
  has_many :scheduled_habits, :class_name => "Schedules::HabitSchedule"

  #has_many :todo_items, :as =>


  attr_accessible :permalink, :name, :why, :how, :bonus_points, :checkin_count, :published, :image, :category_list

  mount_uploader :image, ImageUploader

  # sort by most popular, newest, points, name
  scope :sort_by_popular, order('checkin_count DESC')
  scope :sort_by_newest, order('created_at DESC')
end
