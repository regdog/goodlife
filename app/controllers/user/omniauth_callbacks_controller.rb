class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def handle_unverified_request
      true
  end
  
  def douban
    get_oauth
  end
  
  def tsina
    get_oauth
  end
  
  private
  def get_oauth
    omniauth = env["omniauth.auth"]
    auth = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if auth
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect auth.user
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication with #{omniauth['provider']} successful."
      redirect_to root_path
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect user
      else
        session['devise.omniauth'] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end
end