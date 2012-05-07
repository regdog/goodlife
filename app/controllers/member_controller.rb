class MemberController < ApplicationController

  def index
    @member = User.find(params[:id])
  end

end
