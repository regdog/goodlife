class Admin::RewardsController < Admin::BaseController
  def index
    @search = Reward.search(params[:search])
    if params[:type]
      @view_by = params[:type]
      @category = Category.rewards.find_by_name(params[:type])
      if @category
        @rewards = @category.rewards.page(params[:page])
      end
    else
      @rewards = Reward.order(:name).page(params[:page])
    end
  end

  def new
    @reward = Reward.new
    @reward.build_image
  end

  def create
    @reward = Reward.new(params[:reward])

    if @reward.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @reward = Reward.find(params[:id])
    @search = Reward.search(params[:search])
  end

  def update
    @reward = Reward.find(params[:id])

    if @reward.update_attributes(params[:reward])
      redirect_to :action => "index"
    else
      redirect_to :action => "edit"
    end
  end

  def destroy
    @reward = Reward.find(params[:id])
    @reward.destroy
    redirect_to admin_rewards_path
  end

end
