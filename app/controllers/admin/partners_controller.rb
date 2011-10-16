class Admin::PartnersController < Admin::BaseController
  def index
    @search = Partner.search(params[:search])
    if params[:type]
      @view_by = params[:type]
      @category = Tag.of_kind("Partner").find_by_name(params[:type])
      @partners = @category.partners if @category
    else
      @partners = Partner.all
    end
  end

  def new
    @partner = Partner.new
    @partner.build_image
  end

  def create
    @partner = Partner.new(params[:partner])

    if @partner.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def edit
    #@partner = Partner.find(params[:id]).becomes(Partner)
    @partner = Partner.find(params[:id])
  end

  def update
    @partner = Partner.find(params[:id])

    if @partner.update_attributes(params[:partner])
       redirect_to :action => "index"
    else
       redirect_to :action => "edit"
    end
  end

  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy
    redirect_to admin_partners_path
  end

end
