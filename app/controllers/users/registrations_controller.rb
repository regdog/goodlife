# encoding: UTF-8
class Users::RegistrationsController < Devise::RegistrationsController
  def edit
   @page_title = "我的资料"
  end
end