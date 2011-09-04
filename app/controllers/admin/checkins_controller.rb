class Admin::CheckinsController < Admin::BaseController
  def index
    @search = Checkin.search(params[:search])
    @checkins = @search.all
  end

end
