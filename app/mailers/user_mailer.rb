class UserMailer < ActionMailer::Base
  default from: "code-dojo@sharklasers.com"

  def welcome_email(user)
    @user = user
    mail :to => user.email, :subject => "Welcome!"
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end
