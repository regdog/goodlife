class Partner < ActiveRecord::Base
  belongs_to :category
  has_many :rewards
  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true

  default_scope order('created_at')

  #TYPES = ['LocalRetailer', 'Nonprofit', 'AppProvider', "NationalBrand", "Community"]
end
