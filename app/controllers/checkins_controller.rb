class CheckinsController < ApplicationController

  def index
    if current_user
      @checkins ||= []
      @my_team.each do |m|
        @checkins << m.checkins
      end
      @checkins.flatten!
      @checkins = @checkins.sort_by {|c| [c.created_at]}
    else
      redirect_to :action => 'all'
    end
  end

  def my_challenges
    if current_user
      @checkins = current_user.others_checkins_with_same_feats_of_my_challenges
      render :index
    else
      redirect_to :action => 'all'
    end
  end

  def all
    @checkins = Checkin.all
    render :index
  end
end
