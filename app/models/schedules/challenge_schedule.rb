class Schedules::ChallengeSchedule < ActiveRecord::Base
  set_table_name :scheduled_challenges

  belongs_to :challenge
  belongs_to :user
  delegate :name, :due_on, :to => :challenge

  has_many :checkins_scheduled_tasks, :as => :scheduled
  has_many :checkins, :through => :checkins_scheduled_tasks
  has_many :finished_feats,
           :through => :checkins,
           :source => :feat

  #scope :uncompleted, where(:completed_at => nil )

  def unfinished_feats
    self.challenge.feats - self.finished_feats
  end

  def progress
    (self.finished_feats.count/self.challenge.feats.count)*100
  end
end
