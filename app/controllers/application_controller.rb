class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
