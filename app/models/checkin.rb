class Checkin < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :challenge_checkins
  has_many :challenges, :through => :challenge_checkins

  default_scope  order("created_at DESC")
  scope :epic, where("char_length(memo) > 5")
  #scope :latest, order("created_at DESC")
  #scope :epic, where("char_length(memo) > 5").order("created_at DESC")


## c = Checkin.joins(:feat => :challenges).where(:challenges => {:id => 1})
#  scope :all_for_challenge, lambda { |challenge|
#    {
#        :joins        => {:feat => :challenges},
#        :conditions  =>  {:challenges => {:id => challenge.id}}
##        :select       => "DISTINCT 'checkins'.*"
#    }
#  }
#
## c = Checkin.joins(:feat => :challenges).where(:challenges => {:id => [1,2,3]})
#  scope :all_for_challenges, lambda { |challenge_ids|
#    {
#        :joins        => {:feat => :challenges},
#        :conditions  =>  {:challenges => {:id => challenge_ids}}
##        :select       => "DISTINCT 'checkins'.*"
#    }
#  }

end
