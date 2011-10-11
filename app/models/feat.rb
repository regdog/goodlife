class Feat < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :challenges

  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true

  default_scope order('checkin_count DESC')


  def conv_name
    self.name.force_encoding('UTF-8')
  end
end
