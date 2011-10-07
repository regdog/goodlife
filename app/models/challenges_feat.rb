class ChallengesFeat < ActiveRecord::Base
  belongs_to :feat
  belongs_to :challenge
end
