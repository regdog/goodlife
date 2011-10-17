class ChallengesController < ApplicationController
  def index
    if current_user
      redirect_to mine_challenges_path
    else
      @challenges = Challenge.all
    end
  end

  def mine
    @challenges = current_user.challenges
    @view_by = "mine"
    render :index
  end

  def date
    @challenges = Challenge.sort_by_date
    @view_by = "date"
    render :index
  end

  def popularity
    @challenges = Challenge.sort_by_popularity
    @view_by = "popularity"
    render :index
  end

  def points
    @challenges = Challenge.sort_by_points
    @view_by = "points"
    render :index
  end

  def accept
    @challenge = Challenge.find(params[:id])
    current_user.accept_challenge(@challenge) if user_signed_in?
    redirect_to challenge_path(@challenge)
  end

  def leave
    @challenge = Challenge.find(params[:id])
    current_user.leave_challenge(@challenge) if user_signed_in?
    redirect_to mine_challenges_path
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
