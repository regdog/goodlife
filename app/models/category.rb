class Category < ActiveRecord::Base
  has_many :feats
  has_many :rewards
  has_many :partners
  has_many :contents

  TYPES = ['Feat', 'Reward', 'Partner', 'Content']
  scope :feat_category, where("category_type = 'Feat' ")
  scope :reward_category, where("category_type = 'Reward' ")
  scope :partner_category, where("category_type = 'Partner' ")
  scope :content_category, where("category_type = 'Content' ")
end
