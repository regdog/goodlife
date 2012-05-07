# encoding: UTF-8
class User < ActiveRecord::Base
  include Achievements
  acts_as_friend
  make_flagger

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :uncompleted_scheduled_challenges, :class_name => "Schedules::ChallengeSchedule", :conditions => {:completed_at => nil}
  has_many :completed_scheduled_challenges, :class_name => "Schedules::ChallengeSchedule", :conditions => "completed_at IS NOT NULL"
  has_many :scheduled_habits, :class_name => "Schedules::HabitSchedule"
  has_many :checkins


  # user categories
  CATEGORIES = {
    '我是一个妈妈' => 1,
    '我是一个父亲' => 2,
    '我是一个学生' => 3,
    '我刚刚毕业' => 4,
    '我是工作的成年人' => 5,
    '我是祖父母' => 6,
    '我退休了' => 7,
    '以上都不是' => -1
  }

  # checkin privacy
  PRIVACY = {
     "不要与任何人分享" => 1,
     "只与我的圈子分享" => 2,
     "与任何人分享" => 3
  }

  def friend_ids
    ids ||= []
    self.friends.each do |friend|
      ids << friend.id
    end
    return ids
  end
end
