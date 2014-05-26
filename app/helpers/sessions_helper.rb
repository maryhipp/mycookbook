module SessionsHelper

  # Current User methods:

  def current_user
    remember_token = User.hash(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    current_user == user
  end

  # Signin Status methods:

  def signed_in?
    !current_user.nil?
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
    self.current_user = user
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.hash(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  # Location Management methods:

  def store_location
    if request.get?
      session[:return_to] = request.url
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  # Security Checkpoint method:

  def require_signin
    unless signed_in?
      store_location
      flash[:error] = 'Please sign in.'
      redirect_to signin_url
    end
  end
end
