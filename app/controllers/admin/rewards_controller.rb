class Admin::RewardsController < Admin::BaseController
  def index
    list
    render :action => 'list'
  end

  def list
    @search = Reward.search(params[:search])
    @rewards = @search.all
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
    @search = Reward.search(params[:search])

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

  def list_by_category
    list

    if params[:key]
      @category_search = RewardCategory.search(:name_equals=>params[:key])
      @category = @category_search.all
      if @category.empty?
        redirect_to :action => "index"
        return
      else
        @rewards = @category[0].rewards
        render :action => "list"
      end
    end
  end
end
