class TeamController < ApplicationController
  def index
    @teammates = current_user.friends
    @user = User.new
    @page_title = "Your team"
    @view_by = "Teammates"
  end

  def checkins
    @checkins = current_user.team_checkins
    @page_title = "Your team's check-ins"
    @view_by = "Our Feats"
  end

  def requests
    @outgoing_requests ||= []
    current_user.outgoing_member_requests.each do |request|
      @outgoing_requests << User.find(request.requestee_id)
    end
    @incoming_requests ||= []
    current_user.incoming_member_requests.each do |request|
      @incoming_requests << User.find(request.requestor_id)
    end
    @page_title = "Your requests"
    @view_by = "Requests"
  end

  def invitation
    @page_title = "Invite your friends to your team"
    @view_by = "Invite"
  end

  def invite
    user = User.find_by_email(params[:email])
    if user
      current_user.request_membership(user)
    else
      User.invite!(:email => params[:email], :name => params[:name])
    end
    redirect_to :action => 'requests'
  end
end
