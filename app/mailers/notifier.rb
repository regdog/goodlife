# encoding: UTF-8

# Use Devise Mailer globally to handle all of the mail sending
class Notifier < Devise::Mailer
  default :from => "support@goodlife.com"

  def welcome_mail(user)
    @user = user
    email_with_name = "#{@user.name} <#{@user.email}>"
    @url = "http://127.0.0.l:3000/user/sign_in"
    mail :to => email_with_name, :subject => "欢迎加入Goodlife"
  end

  def checkin_notification(checkin)
    @user = checkin.user
    @feat = checkin.feat
    @url = "http://127.0.0.l:3000/user/sign_in"
    email_with_name = "#{@user.name} <#{@user.email}>"
    mail :to => email_with_name, :subject => "你有一条新的事迹"
  end
end
