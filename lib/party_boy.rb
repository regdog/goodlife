module Party
	module Boy
		
		class IdentityTheftError < StandardError; end
		class StalkerError < StandardError; end
		class TryingTooHardError < StandardError; end 
		
		def self.included(klazz)
			klazz.extend(Party::Boy::ClassMethods)
			klazz.class_eval do 
				include Party::Boy::RelateableInstanceMethods
			end
		end
		
		module ClassMethods
			
			def acts_as_followable
				raise(Party::Boy::TryingTooHardError, "Can't implement both acts_as_followable and acts_as_friendly in the same class.") if self.included_modules.include?(Party::Boy::FriendlyInstanceMethods)
				with_options :class_name => 'Relationship', :dependent => :destroy do |klazz|
				 klazz.has_many :followings, :as => :requestee
				 klazz.has_many :follows, :as => :requestor
				end
				
				include Party::Boy::FollowableInstanceMethods
			end
			
			def acts_as_friend
				raise(Party::Boy::TryingTooHardError, "Can't implement both acts_as_followable and acts_as_friendly in the same class.") if self.included_modules.include?(Party::Boy::FollowableInstanceMethods)
				with_options :class_name => 'Relationship', :dependent => :destroy do |klazz|
					klazz.has_many :outgoing_friendships, :as => :requestor, :include => :requestee
					klazz.has_many :incoming_friendships, :as => :requestee, :include => :requestor
				end

				include Party::Boy::FriendlyInstanceMethods
			end
			
		end
		
		
		module RelateableInstanceMethods
		
		private
		
			# should be able to pass a class, string, or object and get back the super-most class (before activerecord)
			def super_class_name(obj = self)
				if obj.nil?
					return nil
				end
				
				obj = (obj.class == Class && obj || obj.class == String && obj.classify.constantize || obj.class)
				obj.base_class.name
			end
			
			def get_relationship_to(requestee)
				requestee && Relationship.unblocked.find(:first, :conditions => ['requestor_id = ? and requestor_type = ? and requestee_id = ? and requestee_type = ?', self.id, super_class_name, requestee.id, super_class_name(requestee)]) || nil
			end
			
			def get_relationship_from(requestor)
				requestor && Relationship.unblocked.find(:first, :conditions => ['requestor_id = ? and requestor_type = ? and requestee_id = ? and requestee_type = ?', requestor.id, super_class_name(requestor), self.id, super_class_name]) || nil
			end
			
		end
		
		module FollowableInstanceMethods
		
			def following?(something)
				!!(something && Relationship.unblocked.count(:conditions => ['requestor_id = ? and requestor_type = ? and requestee_id = ? and requestee_type = ?', self.id, super_class_name, something.id, super_class_name(something)]) > 0)
			end
			
			def followed_by?(something)
				!!(something && Relationship.unblocked.count(:conditions => ['requestor_id = ? and requestor_type = ? and requestee_id = ? and requestee_type = ?', something.id, super_class_name(something), self.id, super_class_name]) > 0)
			end
			
			def follow(something)
				if blocked_by?(something)
					raise(Party::Boy::StalkerError, "#{super_class_name} #{self.id} has been blocked by #{super_class_name(something)} #{something.id} but is trying to follow them")
				elsif !following?(something)
					Relationship.create(:requestor => self, :requestee => something, :restricted => false)
				end
			end
			
			def blocked_by?(something)
				!!(something && Relationship.blocked.count(:conditions => ['requestor_id = ? and requestor_type = ? and requestee_id = ? and requestee_type = ?', self.id, super_class_name, something.id, super_class_name(something)]) > 0)
			end
			
			def unfollow(something)
				(rel = get_relationship_to(something)) && rel.destroy
			end
			
			def block(something)
				(rel = (get_relationship_from(something) || get_relationship_to(something))) && rel.update_attribute(:restricted, true)
			end
			
			def follower_count(type = nil)
				followings.unblocked.from_type(type).size
			end
			
			def following_count(type = nil)
				follows.unblocked.to_type(type).size
			end
			
			def followers(type = nil, includes = {})
				super_class = super_class_name(type)
				exact_class = type && type.to_s.classify
				results = relationships_from(super_class, includes)
				if super_class && exact_class && super_class != exact_class
					results.collect{|relationship| requestor = relationship.requestor; requestor.class.name == exact_class && requestor || nil}.compact
				else
					results.collect{|relationship| relationship.requestor}
				end
					
			end
			
			def following(type = nil, includes = {})
				super_class = super_class_name(type)
				exact_class = type && type.to_s.classify
				results = relationships_to(super_class, includes)
				if super_class && exact_class && super_class != exact_class
					results.collect{|relationship| requestee = relationship.requestee; requestee.class.name == exact_class && requestee || nil}.compact
				else
					results.collect{|relationship| relationship.requestee}
				end
			end
			
			def network(type = nil)
				[following(type), followers(type)].flatten.uniq
			end
			
			def extended_network(type = nil)
				network(type).collect{|friend| friend.methods.include?('network') && friend.network(type) || []}.flatten.uniq
			end
			
			def method_missing(method, *args)
			  begin
			    super
			  rescue NoMethodError, NameError => e
				  includes = args[0] || {}
  				case method.to_s
  				when /^(.+)ss_followers$/
  					followers("#{$1}ss".classify, includes)
  				when /^(.+)s_followers$/, /^(.+)_followers$/
  					followers($1.classify, includes)
  				when /^following_(.+)$/
  					following($1.classify, includes)
  				else
  					raise e
  				end
  			end
			end
			
			def respond_to?(name, include_private = false)
			  return true if super
			  [/^(.+)ss_followers$/, /^(.+)s_followers$/, /^(.+)_followers$/, /^following_(.+)$/].each{|reg| return true if name.to_s =~ reg}
			  false
			end
			
		private
			
			def relationships_to(type, includes = {})
				self.follows.unblocked.to_type(type).all(:include => [:requestee => includes])
			end
			
			def relationships_from(type, includes = {})
				self.followings.unblocked.from_type(type).all(:include => [:requestor => includes])
			end
			
		end
		
		module FriendlyInstanceMethods
			
			def friends
				(outgoing_friendships.accepted + incoming_friendships.accepted).collect{|relationship| [relationship.requestor, relationship.requestee]}.flatten.uniq - [self]
			end
			
			def extended_network
				friends.collect{|friend| friend.methods.include?('friends') && friend.friends || []}.flatten.uniq - [self]
			end
			
			def outgoing_friend_requests
				self.outgoing_friendships.unaccepted.all
			end
			
			def incoming_friend_requests
				self.incoming_friendships.unaccepted.all
			end
			
			def friends_with?(something)
				arr = something && [self.id, super_class_name, super_class_name(something), something.id]
				arr && Relationship.accepted.count(:conditions => [(['(requestor_id = ? AND requestor_type = ? AND requestee_type = ? AND requestee_id = ?)']*2).join(' OR '), arr, arr.reverse].flatten) > 0
			end
			
			def pending?(something)
				arr = something && [self.id, super_class_name, super_class_name(something), something.id]
				arr && Relationship.unaccepted.count(:conditions => [(['(requestor_id = ? AND requestor_type = ? AND requestee_type = ? AND requestee_id = ?)']*2).join(' OR '), arr, arr.reverse].flatten) > 0
			end
			
			def friend_count
				arr = [self.id, super_class_name]
				Relationship.accepted.count(:conditions => ['(requestor_id = ? AND requestor_type = ?) OR (requestee_id = ? and requestee_type = ?)', arr, arr].flatten)
			end
			
			def request_friendship(friendship_or_something)
				relationship = relationship_from(friendship_or_something)
				relationship.nil? && Relationship.create(:requestor => self, :requestee => friendship_or_something, :restricted => true) || (relationship.requestee == self && relationship.update_attributes(:restricted => false))
			end
			
			def deny_friendship(friendship_or_something)
				(rel = relationship_from(friendship_or_something)) && rel.destroy
			end
			
			
			[:reject_friendship, :destroy_friendship, :leave_friendship].each{|key| alias_method key, :deny_friendship}
			alias_method :accept_friendship, :request_friendship
			
		private
		
			def relationship_from(friendship_or_something)
				if friendship_or_something && friendship_or_something.class == Relationship
					raise(Party::Boy::IdentityTheftError, "#{self.class.name} with id of #{self.id} tried to access Relationship #{friendship_or_something.id}") if !(friendship_or_something.requestor == self || friendship_or_something.requestee == self)
					friendship_or_something
				else
					arr = friendship_or_something && [self.id, super_class_name, super_class_name(friendship_or_something), friendship_or_something.id]
					arr && Relationship.find(:first, :conditions => [(['(requestor_id = ? AND requestor_type = ? AND requestee_type = ? AND requestee_id = ?)']*2).join(' OR '), arr, arr.reverse].flatten) || nil
				end
			end	
			
		end
	end
end

::ActiveRecord::Base.send :include, Party::Boy