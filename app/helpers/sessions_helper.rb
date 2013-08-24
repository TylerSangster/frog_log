module SessionsHelper

  def sign_in(user, remember_me)
    remember_token = User.new_remember_token
    if remember_me 
      cookies.permanent[:remember_token] = remember_token
    else
      cookies[:remember_token] = remember_token
    end
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def require_signed_in
    unless signed_in?
      store_location
      redirect_to login_url, notice: "Please log in."
    end
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def same_user?(user)
    current_user == user
  end

  def require_correct_user
    redirect_to root_url if current_user != User.find(params[:id])
  end

  def require_admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end