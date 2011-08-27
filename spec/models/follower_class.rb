class FollowerClass < ActiveRecord::Base
	include Party::Boy
	
	acts_as_followable
	
	alias_attribute :favorite_businesses, :following_businesses
end
