class Admin::CategoriesController < Admin::BaseController
  #def index
  #  index
  #  render :action => 'index'
  #end

  def index
    @search = Category.search(params[:search])
    if params[:type] && Category::TYPES.include?(params[:type])
      @view_by = params[:type]
      @categories = Category.find_all_by_category_type(@view_by)
    else
      @view_by = "Feat"
      @categories = Category.feats
    end
  end

  def new
    @category = Category.new
    if params[:type] && Category::TYPES.include?(params[:type])
      @category.category_type = params[:type]
    else
      redirect_to :action => "new"
    end
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      redirect_to :action => "index", :type => @category.category_type
    else
      redirect_to :action => "new"
    end
  end

  def edit
    #@category = Category.find(params[:id]).becomes(Category)
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
       redirect_to :action => "index", :type => @category.category_type
    else
       redirect_to :action => "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Category deleted!"
    redirect_to :action => "index", :type => @category.category_type
  end
end
