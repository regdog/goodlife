class ChallengeTodo < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  belongs_to :feat
end
