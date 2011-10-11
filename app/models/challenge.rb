class Challenge < ActiveRecord::Base
  attr_accessible :name, :description, :start_on, :end_on, :feat_tokens, :bonus_points
  belongs_to :creator, :polymorphic => true
  has_many :challenge_checkins
  has_many :checkins, :through => :challenge_checkins
  has_and_belongs_to_many :feats

  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true
  #accepts_nested_attributes_for :feats, :reject_if => lambda { |a| a[:content].blank? }
  attr_reader :feat_tokens

  default_scope order('name DESC')

  def feat_tokens=(ids)
    self.feat_ids = ids.split(",")
  end

  #def checkins
  #  Checkin.all_for_challenge(self)
  #end
end
