class Redemption < ActiveRecord::Base
  belongs_to :user
  belongs_to :reward
end
