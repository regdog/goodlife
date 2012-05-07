class CheckinsScheduledTask < ActiveRecord::Base
  belongs_to :scheduled, :polymorphic => true
  belongs_to :checkin
end
