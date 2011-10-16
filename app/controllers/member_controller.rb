class MemberController < ApplicationController
  def show
    params[:nameid]
    @member = User.find()
  end
end
