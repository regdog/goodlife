class Admin::PartnersController < Admin::BaseController
  def index
    list
    render :action => 'list'
  end

  # Lists content nodes by type
  #
  def list
    # Set current viewing by key
    if params[:type] && Partner::TYPES.include?(params[:type])
      @view_by = params[:type]
      @partners = Partner.find_all_by_type(@view_by)
    else
      @partners = Partner.all
    end
  end

  def new
    @partner = Partner.new
    @partner.build_image

    if params[:type] && Partner::TYPES.include?(params[:type])
      @partner.type = params[:type]
    else
      @partner.type = 'Merchant'
    end
  end

  def create
    @partner = Partner.new(params[:partner])
    @partner.type = params[:partner][:type]

    if @partner.save
      redirect_to :action => "index", :type => @partner.type
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @partner = Partner.find(params[:id]).becomes(Partner)
  end

  def update
    @partner = Partner.find(params[:id])

    if @partner.update_attributes(params[:partner])
       redirect_to :action => "index", :type => @partner.type
    else
       redirect_to :action => "edit"
    end
  end

  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy
    redirect_to :action => "index", :type => @partner.type
    #respond_to do |format|
    #  format.html { redirect_to :action => "index", :type => @partner.type }
    #  format.xml { head :ok }
    #end
  end

end
