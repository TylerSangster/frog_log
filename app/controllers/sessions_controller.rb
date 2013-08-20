class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])
	  if user && user.authenticate(params[:session][:password])	  	
	    session[:user_id] = user.id
	    flash[:success] = "Welcome to Frog Log, #{user.first_name} #{user.last_name}!"
	    redirect_to user 
	  else
	    flash.now[:error] = 'Invalid username and password combination'
	    render "new"
	  end
  end

  def destroy
    flash.now[:success] = 'Thank you using Frog Log!'
    reset_session
    redirect_to new_session_path
  end

end
