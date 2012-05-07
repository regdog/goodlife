class Schedules::HabitSchedule < ActiveRecord::Base
  set_table_name :scheduled_habits

  belongs_to :feat
  belongs_to :user

  has_many :checkins_scheduled_tasks, :as => :scheduled
  has_many :checkins, :through => :checkins_scheduled_tasks
  belongs_to :frequency


end
