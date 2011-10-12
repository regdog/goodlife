class CheckinsController < ApplicationController

  def index
    @checkins = Checkin.all
    redirect_to latest_checkins_path
  end

  def latest
    @checkins = Checkin.all
    render :index
  end

  def epic
    @checkins = Checkin.epic
    render :index
  end

end
