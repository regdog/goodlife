# encoding: UTF-8
class ChallengesController < ApplicationController
  def index
    @page_title = "来个自我挑战吧"
    if current_user
      @challenges = current_user.challenges.page(params[:page]).per(20)
      @view_by = "mine"
    else
      @challenges = Challenge.sort_by_date.page(params[:page]).per(20)
      @view_by = "all"
    end
  end

  def mine
    @challenges = current_user.challenges.page(params[:page]).per(20)
    @view_by = "mine"
    render :index
  end

  def date
    @challenges = Challenge.sort_by_date.page(params[:page]).per(20)
    @view_by = "date"
    render :index
  end

  def popularity
    @challenges = Challenge.sort_by_popularity.page(params[:page]).per(20)
    @view_by = "popularity"
    render :index
  end

  def points
    @challenges = Challenge.sort_by_points.page(params[:page]).per(20)
    @view_by = "points"
    render :index
  end

  def accept
    @challenge = Challenge.find(params[:id])
    if current_user.accept_challenge(@challenge)
      redirect_to challenge_path(@challenge)
    end
  end

  def leave
    @challenge = Challenge.find(params[:id])
    if current_user.leave_challenge(@challenge)
      redirect_to mine_challenges_path
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    @page_title = @challenge.name
  end

  def new
    @challenge = Challenge.new
    @challenge.build_image
    @page_title = "创建新的挑战"
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
