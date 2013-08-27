class PasswordResetsController < ApplicationController
  #before_action :require_signed_in,        only: [:edit, :show]
  
  def new
    render :new
  end

  def show
    redirect_to edit_user_path(current_user)
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :info => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params.permit![:user])
      redirect_to root_url, :info => "Password has been reset!"
    else
      render :edit
    end
  end
end
