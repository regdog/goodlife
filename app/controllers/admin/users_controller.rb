class Admin::UsersController < Admin::BaseController
  def index
    @search = User.search(params[:search])
  end

end
