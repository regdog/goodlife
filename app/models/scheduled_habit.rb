class ScheduledHabit < ScheduledTask
  #set_table_name :scheduled_tasks
  #
  #has_many :checkins_scheduled_tasks, :as => :scheduled
  #has_many :checkins, :through => :checkins_scheduled_tasks
  #belongs_to :frequency
end
