class Admin::PartnersController < Admin::BaseController
  def index
    list
    render :action => 'list'
  end

  # Lists content nodes by type
  #
  def list
    @list_options = Partner::TYPES

    # Set current viewing by key
    if params[:key]
      @view_by = params[:key]
    else
      @view_by = Partner::TYPES[0]
    end

    @partners = Partner.find_all_by_type(@view_by)
  end

  def new
    @partner = Partner.new
    if params[:type] && Partner::TYPES.include?(params[:type])
      @partner.type = params[:type]
    else
      @partner.type = 'Merchant'
    end
  end

  def create
    @partner = Partner.create(params[:partner])
  end

  def edit

  end

  def update

  end
end
