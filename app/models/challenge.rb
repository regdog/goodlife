class Challenge < ActiveRecord::Base
  belongs_to :creator, :polymorphic => true
  has_and_belongs_to_many :feats
  has_many :accepted_challenges
  has_many :users, :through => :accepted_challenges
  has_one :image, :as => :attachable, :dependent => :destroy

  accepts_nested_attributes_for :image, :allow_destroy => true
  #accepts_nested_attributes_for :feats, :reject_if => lambda { |a| a[:content].blank? }

  default_scope order('name DESC')

  def checkins
    Checkin.all_for_challenge(self)
  end
end
