class UsersController < ApplicationController
	before_action :require_signed_in,      only: [:index, :edit, :update]
	# before_action :require_correct_user,		only: [:edit, :update]
  before_action :require_admin_user,     	only: :destroy

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def show
    @user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
      #UserMailer.welcome_email(@user).deliver
      sign_in(@user, false) #do not permanently remember user
			flash[:success] = "Welcome to Code Dojo, #{@user.first_name.capitalize} #{@user.last_name.capitalize}!"
			redirect_to @user
		else
			render action: :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

  def update
  	@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile was updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user_to_delete = User.find(params[:id])
    # if !current_user?(@user_to_delete)
      @user_to_delete.destroy
      flash[:success] = "User exterminated."
      redirect_to users_url
    # else
    #   redirect_to root_url
    # end
  end

private

		def user_params
			params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :avatar, :remove_avatar)
		end

end
