class Challenge < ActiveRecord::Base
  attr_accessible :name, :description, :start_on, :end_on, :feat_tokens, :bonus_points
  belongs_to :creator, :polymorphic => true
  has_and_belongs_to_many :checkins
  has_and_belongs_to_many :feats
  has_many :accepted_challenges
  has_many :participates, :through => :accepted_challenges, :source => :user

  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true
  #accepts_nested_attributes_for :feats, :reject_if => lambda { |a| a[:content].blank? }
  attr_reader :feat_tokens

  # sort by date, popularity, points
  default_scope order('created_at DESC')

  def feat_tokens=(ids)
    self.feat_ids = ids.split(",")
  end

  # completed challenge feats with user
  def completed_feats(user)
    feats ||= []
    user.checkins.with_challenge(self).each do |checkin|
      feats << checkin.feat
    end
  end

  # uncompleted challenge feats with user
  def uncompleted_feats(user)
    self.feats - self.completed_feats(user)
  end
end
