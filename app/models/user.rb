# encoding: UTF-8
require "party_boy"

class User < ActiveRecord::Base
  include Party::Boy
  acts_as_friend

  #uniquify :permalink do
  #  email.split('@').first.downcase << rand(9999999).to_s
  #end
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable,    
         :lockable, :invitable, :invite_for => 2.weeks, :invitation_limit => 5
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me, :category, :location, :phone_number, :self_description,
                  :avatar, :prop_notification, :checkin_notification, :challenge_notification, :checkin_privacy
  validates_presence_of :name, :if => :name_required?
  validates_uniqueness_of :name

  # my authentications
  has_many :authentications, :dependent => :destroy
  # my planned feats
  has_many :planned_todos
  has_many :planned_feats, :through => :planned_todos, :source => :feat
  # my challenges
  has_many :accepted_challenges
  has_many :challenges, :through => :accepted_challenges
  # my checkins
  has_many :checkins
  # my reward wishlist
  has_many :user_wishes
  has_many :wishes, :through => :user_wishes, :source => :reward
  # my redemptions
  has_many :redemptions

  # paperclip
  has_attached_file :avatar, :styles => { :normal => "105x105>", :thumb => "55x55#" }
  validates_attachment_size :avatar, :less_than => 1.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/x-png', 'image/jpg', 'image/jpeg']

  before_create :set_permalink
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

  def set_permalink
    self.permalink = email.split('@').first.downcase << rand(9999999).to_s
  end

  def category_name
    CATEGORIES[category]
  end

  # feats I'v done
  def feats_done
    feats ||= []
    checkins = Checkin.find(:all,
                :conditions => ["checkins.user_id = #{self.id}"],
                :group => 'checkins.user_id, checkins.feat_id')
    checkins.each do |checkin|
      feats << checkin.feat
    end
    return feats
  end

  # checkin a feat
  def checkin(feat)
    User.transaction do
      checkin = Checkin.new(:user_id => self.id, :feat_id => feat.id)
      challenge_ids ||= []
      self.uncompleted_challenges.each do |challenge|
        if challenge.uncompleted_feats(self).include?(feat)
          challenge_ids << challenge.id
        end
      end
      checkin.challenge_ids = challenge_ids
      checkin.save
      self.checkins << checkin
      self.save
      feat.add_counts
    end
  end

  # team checkins
  def team_checkins
    checkins ||= []
    member_ids ||= []
    self.members.each do |member|
      member_ids << member.id
    end
    if member_ids.empty?
      return nil
    else
      checkins = Checkin.where(:user_id => member_ids).order("created_at DESC")
    end
  end

  # users's latest checkins
  def latest_checkins
    self.checkins.latest
  end

  # users's epic checkins
  def epic_checkins
    self.checkins.epic
  end

  # plan feat
  def plan(feat, type)
    plan = PlannedTodo.find_by_user_id_and_feat_id(self.id, feat.id)
    unless plan.nil?
      plan.plan_type = type
    else
      plan = PlannedTodo.new
      plan.user_id = self.id
      plan.feat_id = feat.id
      plan.plan_type = type
    end
    plan.save
  end

  # feat planed type
  def plan_type(feat)
    plan = PlannedTodo.find_by_user_id_and_feat_id(self.id, feat.id)
    unless plan.nil?
      return plan.plan_type
    else
      return nil
    end
  end

  # planned feats: daily, weekly, weekend
  def daily_feats
    feats ||= []
    PlannedTodo.daily(self).each do |plan|
      feats << plan.feat
    end
    return feats
  end

  def weekly_feats
    feats ||= []
    PlannedTodo.weekly(self).each do |plan|
      feats << plan.feat
    end
    return feats
  end

  def weekend_feats
    feats ||= []
    PlannedTodo.weekend(self).each do |plan|
      feats << plan.feat
    end
    return feats
  end

  # accept a challenges
  def accept_challenge(challenge)
    User.transaction do
      if self.challenges.include?(challenge)
        return nil
      #elsif challenge.participable?
      else
        self.challenges << challenge
        self.save
        challenge.add_counts
        accepted_challenge = self.accepted_challenges.last
        accepted_challenge.accepted_on = Time.now
        case challenge.period
          when "1"
            accepted_challenge.complete_on = 1.week.from_now.localtime
          when "2"
            accepted_challenge.complete_on = 2.week.from_now.localtime
          when "3"
            accepted_challenge.complete_on = 3.week.from_now.localtime
          when "4"
            accepted_challenge.complete_on = 1.month.from_now.localtime
          when "5"
            accepted_challenge.complete_on = 2.month.from_now.localtime
        end
        accepted_challenge.save
      end
    end
  end

  # leave a challenges
  def leave_challenge(challenge)
    User.transaction do
      if self.challenges.include?(challenge)
        self.challenges.delete(challenge)
        self.save
        challenge.reduce_counts
      else
        return nil
      end
    end
  end

  # users participated challenge completed or not
  def complete_challenge?(challenge)
    all_feats = challenge.feats
    uncompleted_feats ||= []
    completed_feats ||=[]
    self.checkins.with_challenge(challenge).each do |checkin|
      completed_feats << checkin.feat
    end
    uncompleted_feats = all_feats - completed_feats
    uncompleted_feats.empty?
  end

  # uncompleted participated challenges
  def uncompleted_challenges
    uncompleted ||= []
    self.challenges.each do |challenge|
      unless self.complete_challenge?(challenge)
        uncompleted << challenge
      end
    end
    return uncompleted
  end

  # invite a member
  def request_membership(member)
    self.request_friendship(member)
  end

  # accept a membership
  def accept_membership(member)
    self.accept_friendship(member)
  end

  # remove a membership
  def remove_membership(member)
    self.deny_friendship(member)
  end

  # pending requests?
  def pending_requests(member)
    self.pending?(member)
  end

  # members
  def members
    members = self.friends
    members << self
    members = members.sort_by {|m| [m.earned_points]}.reverse!
    members.flatten
  end

  # invited teammates
  def invited_teammates
    teammates ||= []
    self.outgoing_friend_requests.each do |r|
      teammates << User.find(r.requestee_id)
    end
    return teammates
  end

  # invited by teammates
  def invited_by_teammates
    teammates ||= []
    self.incoming_friend_requests.each do |r|
      teammates << User.find(r.requestor_id)
    end
    return teammates
  end

  # add a reward to wishlist
  def add_wish(reward)
    wish = UserWish.new
    wish.user_id = self.id
    wish.reward_id = reward.id
    wish.save
  end

  # remove a reward from wishlist
  def remove_wish(reward)
    wish = UserWish.find_by_reward_id(reward.id)
    wish.destroy
  end

  # redeem a reward
  def redeem_reward(reward)
    redemption = Redemption.new
    redemption.user_id = self.id
    redemption.reward_id = reward.id
    redemption.save
  end

  # build omniauth
  def apply_omniauth(omniauth)
     authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  # password is not required if oauth already exists
  def password_required? 
     (authentications.empty? || !password.blank?) && super
  end
  
  # name is not required when being invited
  def name_required?
    persisted?
  end
  
  # overwrite devise update_with_password
  def update_with_password(params={})
    if self.encrypted_password.blank? && !self.authentications.empty? #password blank & auth not empty           
      params.delete(:current_password)
      self.update_without_password(params)
      return true
    end
    super
  end

  # overwrite devise update_without_password
  def update_without_password(params={})
    if self.authentications.empty?          
       params.delete(:password)
       params.delete(:password_confirmation)
    end

    result = update_attributes(params)
    clean_up_passwords
    result
  end
  
  # insert data from omniauth into users registration build
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.omniauth'] && session['devise.omniauth']['user_info']
        user.apply_omniauth(session['devise.omniauth'])
        user.name = data['name']
        user.valid?
      end
    end
  end

  # permalink customization
  def to_param
    permalink
  end
end
