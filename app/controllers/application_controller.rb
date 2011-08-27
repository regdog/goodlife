class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_my_team

  def find_my_team
    if current_user
      @my_team ||=[]
      @my_team = current_user.friends
      @my_team << current_user
      @my_team = @my_team.sort_by {|m| [m.sign_in_count]}.reverse!
      @my_team.flatten!
    end
  end
end
