class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery
  before_filter :find_my_team

  def find_my_team
    if current_user
      @my_team ||=[]
      @my_team = current_user.friends
      @my_team << current_user
      @my_team = @my_team.sort_by {|m| [m.sign_in_count]}.reverse!
      @my_team.flatten
    end
  end

  protected

  def layout_by_resource
    if devise_controller?
      "welcome"
    else
      "application"
    end
  end
end
