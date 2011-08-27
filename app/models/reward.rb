class Reward < ActiveRecord::Base
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :categories, :through => :taggings, :source => :reward_category

  default_scope order('redeem_count DESC')
end
