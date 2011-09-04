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
  end

  def create
    @reward = Reward.new(params[:reward])

    respond_to do |format|
      if @reward.save
        format.html { redirect_to(@reward, :notice => 'Reward was successfully created.') }
        format.xml { render :xml => @reward, :status => :created, :location => @reward }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @reward.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @reward = Reward.find(params[:id])
    @search = Reward.search(params[:search])
  end

  def update
    @reward = Reward.find(params[:id])

    respond_to do |format|
      if @reward.update_attributes(params[:reward])
        format.html { redirect_to(@reward,:notice => 'Reward was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @reward.errors,:status => :unprocessable_entity }
      end
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
