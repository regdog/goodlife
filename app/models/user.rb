require "party_boy"

class User < ActiveRecord::Base
  include Party::Boy
  acts_as_friend
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable,    
         :lockable, :invitable, :invite_for => 2.weeks
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me
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


  ## all other people checkins with same feats of my challenges
  #def others_checkins_with_same_feats_of_my_challenges
  #  challenge_ids = self.challenges.map{|x|x.id}.flatten
  #  Checkin.all_for_challenges(challenge_ids).uniq.delete_if{|x| x.user_id == self.id}
  #end
  #
  ## all my challenges contains the feat
  #def challenges_by_feat(feat)
  #  self.challenges.delete_if{|x| not feat.challenges.include?(x)}
  #end

  # checkin a feat
  def checkin(feat)
    checkin = Checkin.new(:user_id => self.id, :feat_id => feat.id)
    if checkin.save
      self.checkins << checkin
      self.save
      challenge_ids = checkin.challenge_ids
      self.uncompleted_challenges.each do |challenge|
        if challenge.uncompleted_feat?(feat)
          challenge_ids << challenge.id
        end
      end
      checkin.update_attributes(:challenge_ids => challenge_ids)
    end
  end

  # team checkins
  def team_checkins
    checkins ||= []
    member_ids ||= []
    self.members.each do |member|
      member_ids << member.id
    end
    checkins = Checkin.where("user_id in ?", member_ids)
  end

  # user's latest checkins
  def latest_checkins
    self.checkins
  end

  # user's epic checkins
  def epic_checkins
    self.checkins.epic
  end

  # accept a challenges
  def accept_challenge(challenge)
    self.challenges << challenge
    self.save
  end

  # leave a challenges
  def leave_challenge(challenge)
    self.challenges.delete(challenge)
    self.save
  end

  # uncompleted challenges
  def uncompleted_challenges
    uncompleted ||= []
    self.challenges.each do |challenge|
      unless challenge.completed?
        uncompleted << challenge
      end
    end
  end

  # invite a member
  def request_membership(member)
    self.request_friendship(member)
    self.save
  end

  # accept a membership
  def accept_membership(member)
    self.accept_friendship(member)
    self.save
  end

  # remove a membership
  def remove_membership(member)
    self.deny_friendship(member)
    self.save
  end

  # pending requests?
  def pending_requests
    self.pending?
  end

  # members
  def members
    members = self.friends
    members << self
    members = members.sort_by {|m| [m.sign_in_count]}.reverse!
    members.flatten
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

end
