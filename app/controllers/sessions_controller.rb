class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])     
      sign_in(user, remember: params[:session][:remember_me])
      redirect_back_or(user)
    else
      flash.now[:error] = 'Invalid email and password combination'
      render "new"
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
