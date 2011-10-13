class PlannedTodo < ActiveRecord::Base
  belongs_to :user
  belongs_to :feat

  TYPES = ['Daily', 'Weekly', 'Weekend']

  scope :daily, lambda {|user| where("plan_type = 'Daily' and user_id = ?", user.id) }
  scope :weekly, lambda {|user| where("plan_type = 'Weekly' and user_id = ?", user.id) }
  scope :weekend, lambda {|user| where("plan_type = 'Weekend' and user_id = ?", user.id) }
end
