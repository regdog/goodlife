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
    @requests ||= []
    current_user.invited_by_teammates.each do |m|
      @requests << m
    end
    current_user.invited_teammates.each do |m|
      @requests << m
    end

    @page_title = "Requests to join teams"
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
      invited_user = User.find_by_email_and_name(params[:email], params[:name])
      current_user.request_membership(invited_user)
    end
    redirect_to :action => 'requests'
  end

  def join
    user = User.find(params[:member])
    if current_user.accept_membership(user)
      redirect_to :action => 'index'
    end
  end
end
