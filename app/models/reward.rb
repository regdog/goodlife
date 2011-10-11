class Reward < ActiveRecord::Base
  belongs_to :category
  belongs_to :partner
  has_many :user_wishes
  has_many :wanted_users, :through => :user_wishes, :source => :user

  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true

  #scope :locals, where()
  #scope :premium, where()

  #def partner_tokens=(ids)
  #  self.partner_id = ids.split(",")
  #end
end
