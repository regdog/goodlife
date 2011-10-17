class TeamController < ApplicationController
  def checkins
    @checkins = current_user.team_checkins
  end

  def requests
    @requests = current_user.daily_feats
  end

  def members
    @friends = current_user.friends
  end
end
