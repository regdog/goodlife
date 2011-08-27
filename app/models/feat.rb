class Feat < ActiveRecord::Base
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :categories, :through => :taggings, :source => :feat_category
  has_many :checkins
  belongs_to :challenge

  default_scope order('done_count DESC')
end
