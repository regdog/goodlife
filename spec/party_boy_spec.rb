require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


describe "party_boy" do
	
	it "should integrate follower methods properly" do
		%w(followers following following? followed_by?).each do |method|
	   	FollowerClass.new.methods.include?(method).should be_true
		end
	end
	
	it "should integrate friend methods properly" do
		%w(friends outgoing_friend_requests incoming_friend_requests extended_network).each do |method|
	   	FriendClass.new.methods.include?(method).should be_true
		end
	end
	
	
	it "should validate relationships properly" do
		a = FollowerClass.create
		b = FollowerClass.create
		
		r = Relationship.new(:requestor => a, :requestee => b, :restricted => false)
		r.should be_valid
		
		r2 = Relationship.new(:requestor => a, :restricted => false)
		r2.should_not be_valid
	
		r3 = Relationship.new(:requestee => b, :restricted => true)
		r3.should_not be_valid
	end
	
	
	it "should not allow multiple implementations in one model" do 
		lambda {
			require 'models/both_class'
			}.should raise_error(Party::Boy::TryingTooHardError)
	end
	
end

describe "party_boy -- follower" do
	it "should generate relationships and return proper counts" do
		a = FollowerClass.create
		b = FollowerClass.create

		a.follow(b)
		
		r = Relationship.last

		r.requestor.should eql(a)
		r.requestee.should eql(b)
		r.blocked.should be_false
		
		a.following_count.should eql(1)
		a.follower_count.should eql(0)
		
		b.following_count.should eql(0)
		b.follower_count.should eql(1)
	end
	
	it "should generate and destroy relationships from party_boy models" do
		a = FollowerClass.create
		b = FollowerClass.create
		
		a.follow(b)
		
		a.following_count.should eql(1)
		
		a.unfollow(b)
		a.following_count.should eql(0)
		
	end
		
	it "should restrict relationships properly" do
		a = FollowerClass.create
		b = FollowerClass.create

		r = a.follow(b)
		
		b.block(a)
		
		a.following_count.should eql(0)
		b.follower_count.should eql(0)
		
		r.reload
		r.blocked.should be_true
		
		lambda { a.follow(b) }.should raise_error(Party::Boy::StalkerError)
		
		a.following_count.should eql(0)
		b.follower_count.should eql(0)
	
		b.follow(a)
		
		a.follower_count.should eql(1)
		b.following_count.should eql(1)
		
	end
	
	
	it "should collect relationship personnel properly" do
		a = FollowerClass.create
		b = FollowerClass.create
		c = FollowerClass.create
		d = FollowerClass.create
		e = FollowerClass.create
		
		a.follow(b)
		b.follow(c)
		a.follow(c)
		c.follow(d)
		e.follow(c)
		e.follow(a)
		
		a.followers.empty?.should be_false
		a.following.size.should eql(2)
		a.following.sort{|m,n| m.id <=> n.id}.should eql([b,c])
		
		c.followers.size.should eql(3)
		c.followers.sort{|m,n| m.id <=> n.id}.should eql([a,b,e])
		
		a.network.sort{|m,n| m.id <=> n.id}.should eql([b,c,e])
		a.extended_network.include?(d).should be_true
		a.extended_network.include?(e).should be_true
	end
	
	
	class User < FollowerClass; end
	class Business < FollowerClass; 
		has_many :programs
	end
	class Program < FollowerClass; end
	
	it "should handle STI properly" do 
		u = User.create
		b = Business.create
		
		u.follow(b)
		
		b.followers.first.class.name.should eql('User')
		u.following.first.class.name.should eql('Business')
	end
	
	it "should handle passed data types properly" do 
		u = User.create
		b = Business.create
		p = Program.create
		
		u.follow(b)
		u.follow(p)
		
		u.following(Business).should eql([b])
		u.following(Program).should eql([p])
		u.following.size.should eql(2)
		
		u.following('Business').should eql([b])
		u.following('businesses').should eql([b])
		u.following('Program').should eql([p])
		u.following('programs').should eql([p])
		
		u.following.size.should eql(2)
	end
	
	it "should handle method_missing properly" do
		u = User.create
		b = Business.create
		u2 = User.create
		b2 = Business.create
		
		u.follow(u2)
		u.follow(b)
		u.follow(b2)

		u.following.size.should eql(3)
		u.following_businesses.size.should eql(2)
		u.favorite_businesses.size.should eql(2)
		u.following_users.size.should eql(1)
		
		b.follow(u)
		b.follow(u2)
		b.follow(b2)
		
		b2.followers.size.should eql(2)
		b2.user_followers.size.should eql(1)
		b2.business_followers.size.should eql(1)
		b2.follower_class_followers.size.should eql(2)
		
	end
	
	it "should handle includes properly" do 
		u = User.create
		b = Business.create
		b2 = Business.create
		b3 = Business.create
		
		[b,b2,b3].each{|biz| biz.programs.create}
		
		u.follow(b)
		u.follow(b2)
		u.follow(b3)
		
		bizs = u.following_businesses(:programs)
		bizs.each do |biz|
			biz.programs.loaded?.should be_true
		end
		
		bizs = u.following_businesses
		bizs.each do |biz|
			biz.programs.loaded?.should be_false
		end
	end
	
end


describe "party_boy - friend" do 
	
	it "should make and break friendships properly" do
		a = FriendClass.create
		b = FriendClass.create
		
		r = a.request_friendship(b)
		r.accepted?.should be_false
		
		b.incoming_friend_requests.size.should eql(1)
		a.outgoing_friend_requests.size.should eql(1)
		
		b.accept_friendship(a)
		
		a.friends.should eql([b])
		b.friends.should eql([a])
		
		a.leave_friendship(b)
		
		a.friends.empty?.should be_true
		b.friends.empty?.should be_true
		
		a.request_friendship(b)
		b.request_friendship(a)
		
		a.friends.should eql([b])
		b.friends.should eql([a])
	end
	
	it "should return proper counts and states" do
		a = FriendClass.new
		b = FriendClass.new
		c = FriendClass.new
		d = FriendClass.new
		
		a.request_friendship(b)
		a.request_friendship(c)
		b.request_friendship(c)
		
		a.pending?(b).should be_true
		a.pending?(c).should be_true
		a.pending?(d).should be_false
		
		b.accept_friendship(a)
		c.accept_friendship(a)
		c.reject_friendship(b)
		
		a.friend_count.should eql(2)
		b.friend_count.should eql(1)
		c.friend_count.should eql(1)
		
		a.friends_with?(b).should be_true
		c.friends_with?(a).should be_true
		b.friends_with?(c).should be_false
	end
	
end

