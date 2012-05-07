class WelcomeController < ActionController::Base
  before_filter :authenticate_user!, :except => :index

  def index
    #if user_signed_in?
    #  redirect_to :controller => "home"
    #else
    #  render :layout => "welcome"
    #end
    render :layout => "welcome"
  end
end
