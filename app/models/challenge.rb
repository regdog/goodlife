class Challenge < ActiveRecord::Base
  has_and_belongs_to_many :feats
  has_many :scheduled_challenges, :class_name => "Schedules::ChallengeSchedule"
end
