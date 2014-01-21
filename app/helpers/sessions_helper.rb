module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by_remember_token(remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.new_remember_token)
    cookies.delete(:remember_token)
    @current_user = nil
  end

  private
  def authenticate
    deny_access unless signed_in?
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => 'Please sign in to access this page'
  end

  def current_user?(user)
    user == current_user
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or(default)
    redirect_to session[:return_to] || default
    clear_location
  end

  def clear_location
    session[:return_to] = nil
  end
end
