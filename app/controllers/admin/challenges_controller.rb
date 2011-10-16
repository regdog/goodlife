class Admin::ChallengesController < Admin::BaseController
  def index
    @search = Challenge.search(params[:search])
    @challenges = Challenge.order(:name).page(params[:page]).per(8)
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.new(params[:challenge])
    @challenge.creator = current_admin_user.partner if current_admin_user.partner

    if @challenge.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @challenge = Challenge.find(params[:id])
    @search = Challenge.search(params[:search])
  end

  def update
    @challenge = Challenge.find(params[:id])

    if @challenge.update_attributes(params[:challenge])
      redirect_to :action => "index"
    else
      redirect_to :action => "edit"
    end
  end

  def destroy
    @challenge = Challenge.find(params[:id])
    @challenge.destroy
    redirect_to admin_challenges_path
  end
end
