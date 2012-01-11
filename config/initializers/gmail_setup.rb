ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "goodlife.com",
  :user_name            => "sinoyang",
  :password             => "cj1979111",
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}

# ActionMailer::Base.default_url_options[:host] = "localhost:3000"