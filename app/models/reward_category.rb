class RewardCategory < Tag
  has_many :taggings, :foreign_key => "tag_id", :dependent => :destroy
  has_many :rewards, :through => :taggings, :dependent => :destroy
end
