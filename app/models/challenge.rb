class Challenge < ActiveRecord::Base
  attr_accessible :name, :description, :start_on, :end_on, :feat_tokens, :bonus_points
  belongs_to :creator, :polymorphic => true
  has_many :challenges_feats
  has_many :feats, :through => :challenges_feats
  has_many :accepted_challenges
  has_many :users, :through => :accepted_challenges
  has_one :image, :as => :attachable, :dependent => :destroy

  accepts_nested_attributes_for :image, :allow_destroy => true
  #accepts_nested_attributes_for :feats, :reject_if => lambda { |a| a[:content].blank? }
  attr_reader :feat_tokens

  default_scope order('name DESC')

  def feat_tokens=(ids)
    self.feat_ids = ids.split(",")
  end

  def checkins
    Checkin.all_for_challenge(self)
  end
end
