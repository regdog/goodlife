class Checkin < ActiveRecord::Base
  belongs_to :user
  belongs_to :feat
  has_many :comments, :dependent => :destroy
  has_and_belongs_to_many :challenges

  scope :latest, order("created_at DESC")
  scope :epic, where("char_length(memo) > 5").order("created_at DESC")
  scope :with_challenge, lambda { |challenge| includes(:challenges).where("challenges.id = ?", challenge.id) }

  after_create :earn_points

  def earn_points
    ActiveRecord::Base.transaction do
      user = self.user
      user.earned_points = user.earned_points + self.feat.bonus_points
      self.challenges.each do |challenge|
        if user.challenge_completed?(challenge)
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
