class Checkin < ActiveRecord::Base
  belongs_to :user
  belongs_to :feat
  has_many :comments, :dependent => :destroy
  has_and_belongs_to_many :challenges

  scope :everyone, where("privacy = 3")
  scope :teammates, where("privacy >= 2")
  scope :latest, order("created_at DESC")
  #scope :epic, where("epic = 1").order("created_at DESC")
  scope :epic, where("epic = 'TRUE'").order("created_at DESC")   # FOR POSTGRESQL
  scope :with_challenge, lambda { |challenge| includes(:challenges).where("challenges.id = ?", challenge.id) }

  after_create :earn_points
  before_save :against_challenges

  def against_challenges
    ActiveRecord::Base.transaction do
      user = self.user
      challenge_ids ||= []
      user.uncompleted_challenges.each do |challenge|
        if challenge.uncompleted_feats(user).include?(self.feat)
          challenge_ids << challenge.id
        end
      end
      self.challenge_ids = challenge_ids
      self.feat.add_counts
    end
  end

  def earn_points
    ActiveRecord::Base.transaction do
      user = self.user
      user.earned_points = user.earned_points + self.feat.bonus_points
      self.challenges.each do |challenge|
        if user.complete_challenge?(challenge)
          user.earned_points = user.earned_points + challenge.bonus_points
        end
      end
      user.save
      feat = self.feat
      feat.checkin_count = feat.checkin_count + 1
      feat.save
    end
  end
end
