class CheckinsController < ApplicationController

  def index
    redirect_to latest_checkins_path
  end

  def latest
    @checkins = Checkin.order("created_at DESC").all
    render :index
  end

  def epic
    @checkins = Checkin.epic
    render :index
  end

end
