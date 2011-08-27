class FriendClass < ActiveRecord::Base
	include Party::Boy
	
	acts_as_friend
end
