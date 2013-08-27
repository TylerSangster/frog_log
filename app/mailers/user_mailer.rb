class UserMailer < ActionMailer::Base
  default from: "codedojomailer@gmail.com"

  def welcome_email(user)
    @user = user
    mail :to => user.email, :subject => "Welcome to Code Doho!"
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end
