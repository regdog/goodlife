# encoding: UTF-8
class Challenge < ActiveRecord::Base
  attr_reader :feat_tokens
  uniquify :permalink, :chars => 0..9
  belongs_to :creator, :polymorphic => true
  has_and_belongs_to_many :checkins
  has_and_belongs_to_many :feats
  has_many :accepted_challenges
  has_many :participants, :through => :accepted_challenges, :source => :user

  has_one :image, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :image, :allow_destroy => true
  #accepts_nested_attributes_for :feats, :reject_if => lambda { |a| a[:content].blank? }

  # sort by date, popularity, points
  scope :sort_by_date, order('created_at DESC')
  scope :sort_by_points, order('bonus_points DESC').order('created_at DESC')
  scope :sort_by_popularity, order('participants_count DESC').order('created_at DESC')
  SORT_TYPES = ['My Challenges', 'By Date', 'By Popularity', 'By Points']

  PERIODS = {
    '1个星期' => 1,
    '2个星期' => 2,
    '3个星期' => 3,
    '1个月' => 4,
    '2个月' => 5
  }

  def feat_tokens=(ids)
    self.feat_ids = ids.split(",")
  end

  def feat_tokens
    ids ||= []
    self.feats.each do |f|
      ids << f.id
    end
    ids.join(",");
  end

  # completed challenge feats with users
  def completed_feats(user)
    feats ||= []
    user.checkins.with_challenge(self).each do |checkin|
      feats << checkin.feat
    end
    return feats
  end

  # uncompleted challenge feats with users
  def uncompleted_feats(user)
    self.feats - self.completed_feats(user)
  end

  def participable?(user)
    return true
    #if self.end_on > Time.now
    #  return true
    #else
    #  return false
    #end
  end

  def add_counts
    self.participants_count = self.participants_count + 1
    self.save
  end

  def reduce_counts
    self.participants_count = self.participants_count - 1
    self.save
  end

  #def start_on_string
  #  start_on.strftime("%Y/%m/%d %H:%M") if start_on
  #end
  #
  #def start_on_string=(datetime_str)
  #  self.start_on = Time.parse(datetime_str) rescue nil
  #end
  #
  #def end_on_string
  #  end_on.strftime("%Y/%m/%d %H:%M") if end_on
  #end
  #
  #def end_on_string=(datetime_str)
  #  self.end_on = Time.parse(datetime_str) rescue nil
  #end

  def to_param
    permalink
  end
end
