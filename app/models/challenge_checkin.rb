class ChallengeCheckin < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :checkin
end
