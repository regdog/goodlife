class Feat < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :challenges

  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true

  default_scope order('checkin_count DESC')

  # scope latest checkins for a specific feat
  # scope epic checkins for a specific feat

  # sort by most popular, newest, points, name

  # planned feats: daily, weekly, weekend, feats I've done

  #
end
