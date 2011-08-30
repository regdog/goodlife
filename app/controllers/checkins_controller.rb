class CheckinsController < ApplicationController

  def index
    if current_user
      redirect_to :action => 'show_my_team'
    else
      redirect_to :action => 'all'
    end
  end

  def show_my_team
    if current_user
      @checkins ||= []
      @my_team.each do |m|
        @checkins << m.checkins
      end
      @checkins.flatten!
      @checkins = @checkins.sort_by {|c| [c.created_at]}
      render :index, :collection =>  @checkins
    else
      redirect_to :action => 'all'
    end
  end

  def show_my_challenges
    if current_user
      @checkins = current_user.others_checkins_with_same_feats_of_my_challenges
      render :index, :collection => @checkins
    else
      redirect_to :action => 'all'
    end
  end

  def all
    @checkins = Checkin.all
    render :index, :collection => @checkins
  end
end
