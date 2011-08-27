require "party_boy"

class User < ActiveRecord::Base
  include Party::Boy
  acts_as_friend
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable, :invite_for => 2.weeks

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :checkins
  has_and_belongs_to_many :challenges

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
end
