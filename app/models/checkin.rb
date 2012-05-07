class Checkin < ActiveRecord::Base
  make_flaggable :like

  belongs_to :feat
  belongs_to :user
  has_many :comments

  has_many :checkins_scheduled_tasks

  has_many :scheduled_challenges,
           :through => :checkins_scheduled_tasks,
           :source => :scheduled,
           :source_type => "Schedules::ChallengeSchedule"

  has_many :scheduled_habits,
           :through => :checkins_scheduled_tasks,
           :source => :scheduled,
           :source_type => "Schedules::HabitSchedule"

  #scope :mine, lambda {|user_id| where("user_id = ?", user_id)}
  scope :friends, lambda {|user_ids| where("user_id in (?)", user_ids)}
  scope :epics, where(:epic => true)
end
