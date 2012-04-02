class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :session_expiration
  before_filter :authorize, :except => :login

  protected
  def session_expiration
    if session[:expire_at] and session[:expire_at] < DateTime.now 
#      flash[:notice] = "Session expired"
      reset_session
    end
    session[:expire_at] = 30.minutes.since DateTime.now
  end

  def authorize
    if u = User.find_by_id(session[:user_id])
      u.touch(:last_seen)
    else
      session[:original_uri] = request.url
      flash[:notice] = "Please log in"
      redirect_to :login
    end
  end
end
