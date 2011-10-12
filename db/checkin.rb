class Checkin < ActiveRecord::Base
  belongs_to :user
  belongs_to :feat
  has_many :comments, :dependent => :destroy

  default_scope order("created_at DESC")

# c = Checkin.joins(:feat => :challenges).where(:challenges => {:id => 1})
  scope :all_for_challenge, lambda { |challenge|
    {
        :joins        => {:feat => :challenges},
        :conditions  =>  {:challenges => {:id => challenge.id}}
#        :select       => "DISTINCT 'checkins'.*"
    }
  }

# c = Checkin.joins(:feat => :challenges).where(:challenges => {:id => [1,2,3]})
  scope :all_for_challenges, lambda { |challenge_ids|
    {
        :joins        => {:feat => :challenges},
        :conditions  =>  {:challenges => {:id => challenge_ids}}
#        :select       => "DISTINCT 'checkins'.*"
    }
  }

end
