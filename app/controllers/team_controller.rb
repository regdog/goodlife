class TeamController < ApplicationController
  def checkins
    @checkins = current_user.checkins
  end

  def requests
    @requests = current_user.daily_feats
  end

  def members
    @members = current_user.friends
  end
end
