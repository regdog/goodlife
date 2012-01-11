# encoding: UTF-8
class WelcomeController < ApplicationController
  layout 'welcome'

  def index
    if user_signed_in?
      redirect_to feats_path
    end
  end
end
