class FeatCategory < Tag
  has_many :taggings, :foreign_key => "tag_id", :dependent => :destroy
  has_many :feats, :through => :taggings, :dependent => :destroy
end
