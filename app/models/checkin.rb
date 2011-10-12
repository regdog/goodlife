class Checkin < ActiveRecord::Base
  belongs_to :user
  belongs_to :feat
  has_many :comments, :dependent => :destroy
  has_and_belongs_to_many :challenges

  default_scope  order("created_at DESC")
  scope :epic, where("char_length(memo) > 5")

end
