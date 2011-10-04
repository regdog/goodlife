class Challenge < ActiveRecord::Base
  has_and_belongs_to_many :feats
  has_many :accepted_challenges
  has_many :users, :through => :accepted_challenges

  def checkins
    Checkin.all_for_challenge(self)
  end
end
