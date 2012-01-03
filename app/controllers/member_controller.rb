# encoding: UTF-8
class MemberController < ApplicationController
  def show
    id = params[:nameid]
    @member = User.find(id)
    @page_title = "#{@member.name}"
  end
end
