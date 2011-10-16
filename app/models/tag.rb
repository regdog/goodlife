class Tag < ActiveRecord::Base
  has_many :partners
  has_many :contents
  has_many :taggings, :dependent => :destroy
  has_many :feats, :through => :taggings, :source => :feat
  has_many :rewards, :through => :taggings, :source => :reward

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :kind

  scope :with_name_like_and_kind, lambda { |name, kind| { :conditions => ["name like ? AND kind = ?", "%#{name}%", kind] } }
  scope :of_kind, lambda { |kind| { :conditions => {:kind => kind} } }

  KINDS = ['Feat', 'Reward', 'Partner', 'Content']
end
