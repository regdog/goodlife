class WelcomeController < ApplicationController
  layout 'welcome'

  def index
    if user_signed_in?
      redirect_to home_path
    end
  end

  def home
  end
end
