class UserMailer < ActionMailer::Base
  default from: "sensei@code-dojo.com"

  def welcome_email(user)
    @user = user
    mail :to => user.email, :subject => "Welcome young padawan!"
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset link"
  end
end
