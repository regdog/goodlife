class Comment < ActiveRecord::Base
  belongs_to :checkin
  belongs_to :user

  validates_presence_of :content, :checkin_id

  default_scope order('created_at DESC')
end
