class Challenge < ActiveRecord::Base
  has_and_belongs_to_many :feats
  has_and_belongs_to_many :users

  def checkins
    Checkin.all_for_challenge(self)
  end
end
