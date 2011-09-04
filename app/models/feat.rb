class Feat < ActiveRecord::Base
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :categories, :through => :taggings, :source => :feat_category
  has_many :checkins
  has_and_belongs_to_many :challenges

  default_scope order('done_count DESC')

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
    self.categories << FeatCategory.find(id) if !id.nil?
  end
end
