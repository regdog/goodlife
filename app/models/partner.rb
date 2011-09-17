class Partner < ActiveRecord::Base
  has_many :rewards
  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true

  default_scope order('created_at')

  TYPES = ['Merchant', 'Distributor', 'Sponsor']
end
