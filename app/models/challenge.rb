class Challenge < ActiveRecord::Base
  attr_accessible :name, :description, :start_on, :end_on, :feat_tokens, :bonus_points
  belongs_to :creator, :polymorphic => true
  has_and_belongs_to_many :checkins
  has_and_belongs_to_many :feats

  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true
  #accepts_nested_attributes_for :feats, :reject_if => lambda { |a| a[:content].blank? }
  attr_reader :feat_tokens

  # sort by date, popularity, points
  default_scope order('created_at DESC')

  def feat_tokens=(ids)
    self.feat_ids = ids.split(",")
  end

  # challenge completed or not
  def completed?
    all_feats = self.feats
    completed_feats ||= []
    self.checkins.each do |checkin|
      completed_feats << checkin.feat
    end
    uncompleted_feats = all_feats - completed_feats
    uncompleted_feats.empty?
  end

  # completed feats with challenge
  def completed_feats
    feats ||= []
    self.checkins.each do |checkin|
      feats << checkin.feat
    end
  end

  def uncompleted_feat?(feat)
    if self.feats.include?(feat)
      if !self.completed_feats.include?(feat)
        true
      else
        false
      end
    else
      return nil
    end
  end

end
