class Category < ActiveRecord::Base
  has_many :feats
  has_many :rewards
  has_many :partners
  has_many :contents

  TYPES = ['Feat', 'Reward', 'Partner', 'Content']
  scope :feats, where("category_type = 'Feat' ")
  scope :rewards, where("category_type = 'Reward' ")
  scope :partners, where("category_type = 'Partner' ")
  scope :contents, where("category_type = 'Content' ")
end
