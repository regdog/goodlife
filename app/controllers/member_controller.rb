class MemberController < ApplicationController
  def show
    id = params[:nameid]
    @member = User.find(id)
  end
end
