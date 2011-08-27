class BothClass < ActiveRecord::Base
	include Party::Boy
	
	acts_as_friend
	acts_as_followable
	
end
