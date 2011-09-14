class Reward < ActiveRecord::Base
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :categories, :through => :taggings, :source => :reward_category
  belongs_to :partner

  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true

  default_scope order('redeem_count DESC')

  def category_id
    unless self.categories.empty?
      category = self.categories[0]
      category.id
    else
      0
    end
  end

  def category_id=(id)
    self.taggings.clear if !self.categories.empty?
    self.categories << RewardCategory.find(id) if !id.nil?
  end
end
