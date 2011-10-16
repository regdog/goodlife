class ChallengesController < ApplicationController
  def index
    redirect_to mine_challenges_path
  end

  def mine
    @challenges = current_user.challenges
    @view_by = "mine"
    render :index
  end

  def by_date
    @challenges = Challenge.sort_by_date
    @view_by = "by_date"
    render :index
  end

  def by_popularity
    @challenges = Challenge.sort_by_popularity
    @view_by = "by_popularity"
    render :index
  end

  def by_points
    @challenges = Challenge.sort_by_points
    @view_by = "by_date"
    render :index
  end

  def show
    @challenge = Challenge.find(params[:id])
  end

  def new
    @challenge = Challenge.new
    @challenge.build_image
    @view_by = "new"
  end

  def create
    return nil if current_user.nil?
    @challenge = Challenge.new(params[:challenge])
    @challenge.creator = current_user
    if @challenge.save
      current_user.accept_challenge(@challenge)
      redirect_to mine_challenges_path
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @challenge = Challenge.find(params[:id])
  end

  def update
    @challenge = Challenge.find(params[:id])

    if @challenge.update_attributes(params[:challenge])
      redirect_to challenges_feats_path
    else
      redirect_to :action => "edit"
    end
  end
end
