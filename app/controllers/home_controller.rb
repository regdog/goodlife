class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  has_widgets do |root|
    root << widget(:checkin)
  end

  def index
    if user_signed_in?
      @habits = current_user.scheduled_habits
      @challenges = current_user.uncompleted_scheduled_challenges
    else
      redirect_to :controller => "welcome"
    end
  end

end
