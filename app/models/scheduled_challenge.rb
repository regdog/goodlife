class ScheduledChallenge < ScheduledTask
  #set_table_name :scheduled_tasks
  #has_many :checkins_scheduled_tasks,
  #         :as => :scheduled
  #
  #has_many :checkins,
  #         :through => :checkins_scheduled_tasks
  #
  #has_many :finished_feats,
  #         :through => :checkins,
  #         :source => :feat
  #
  #scope :uncompleted, where(:completed_at => nil )
  #
  #def unfinished_feats
  #  self.task.feats - self.finished_feats
  #end
end
