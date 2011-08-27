class Challenge < ActiveRecord::Base
  has_many :feats
  has_and_belongs_to_many :users

end
