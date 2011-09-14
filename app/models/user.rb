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
  
  has_many :authentications, :dependent => :destroy
  has_many :checkins
  has_and_belongs_to_many :challenges

  # all other people checkins with same feats of my challenges
  def others_checkins_with_same_feats_of_my_challenges
    challenge_ids = self.challenges.map{|x|x.id}.flatten
    Checkin.all_for_challenges(challenge_ids).uniq.delete_if{|x| x.user_id == self.id}
  end

  # all my challenges contains the feat
  def challenges_by_feat(feat)
    self.challenges.delete_if{|x| not feat.challenges.include?(x)}
  end

  # accept a challenge
  def accept_challenge(challenge)
    self.challenges << challenge
    self.save
  end

  # leave a challenge
  def leave_challenge(challenge)
    self.challenges.delete(challenge)
    self.save
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
  
  # insert data from omniauth into user registration build
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
