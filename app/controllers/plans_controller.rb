class PlansController < ApplicationController
  def index
    redirect_to
  end

  def plans
    @feats = current_user.planned_feats
  end

  def challenges
    @challenges = current_user.challenges
  end

end
