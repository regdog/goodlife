# encoding: UTF-8
class PlannedFeat < ActiveRecord::Base
  belongs_to :user
  belongs_to :feat

  TYPES = ['Daily', 'Weekly', 'Weekend']

  PLANS = {
      'daily' => "每天",
      'weekly' => "每周",
      'weekend' => "每周末"
  }

  scope :daily, lambda {|user| where("plan_type = 'Daily' and user_id = ?", user.id) }
  scope :weekly, lambda {|user| where("plan_type = 'Weekly' and user_id = ?", user.id) }
  scope :weekend, lambda {|user| where("plan_type = 'Weekend' and user_id = ?", user.id) }
end
