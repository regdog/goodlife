class Checkin < ActiveRecord::Base
  belongs_to :user
  belongs_to :feat

  has_many :comments, :dependent => :destroy

  default_scope order("created_at DESC")
end
