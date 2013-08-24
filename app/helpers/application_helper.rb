module ApplicationHelper

  @@base_title = "Code Dojo"

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    if page_title.empty?
      @@base_title
    else
      "#{@@base_title} | #{page_title}"
    end
  end

  # Returns the header on a per-page basis.
  def header_text(page_title)
    page_title || @@base_title
  end

  def set_current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_current_user
    redirect_to login_url, alert: "Please login" unless set_current_user
  end

  def same_user?(user)
    set_current_user == user
  end

  def require_correct_user
    redirect_to root_url if set_current_user != User.find(params[:id])
  end

  def require_admin_user
    redirect_to(root_url) unless set_current_user.admin?
  end

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
end