class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery
  before_filter :load_corp_pages

  protected

  def layout_by_resource
    if devise_controller?
      "welcome"
    else
      "application"
    end
  end

  def load_corp_pages
    tag = Tag.find_by_name("Page")
    @pages = tag.contents
  end
end
