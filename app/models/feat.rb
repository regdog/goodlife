class Feat < ActiveRecord::Base
  belongs_to :category
  has_many :checkins
  has_many :challenges_feats
  has_many :challenges, :through => :challenges_feats

  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true

  default_scope order('checkin_count DESC')


  def conv_name
    self.name.force_encoding('UTF-8')
  end
end
