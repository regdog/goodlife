class CheckinsController < ApplicationController

  def index
    @checkins = Checkin.latest
  end

  def epic
    @checkins = Checkin.epic
    render :index
  end

end
