class UsersController < ApplicationController
	
	def index
		"Temporary placeholder"
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			# session[:user_id] = @user.user_id
			flash[:success] = "Welcome to Frog, #{@user.first_name.capitalize} #{@user.last_name.capitalize}!"
			redirect_to root_path
		else
			render action: :new
		end
	end

	private

		def user_params
			params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
		end

end
