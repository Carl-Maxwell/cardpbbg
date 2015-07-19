class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by_session_token(
      session[:session_token],
      request.user_agent
    )
  end

  def logged_in?
    !!current_user
  end

  def login(name, password)
    user = User.find_by_credentials(name, password)
    if user
      reset_session
      current_session = user.sessions.build
      current_session.useragent = request.user_agent

      return nil unless current_session.save!

      session[:session_token] = current_session.session_token

      user
    else
      nil
    end
  end

  def logout
    raise "User must be logged in before calling logout!" unless logged_in?

    Session.find_by(session_token: session[:session_token]).destroy
    session[:session_token] = nil
  end

  def require_user
    redirect_to new_sessions_url unless logged_in?
  end

  def require_guest
    redirect_to root_url if logged_in?
  end
end
