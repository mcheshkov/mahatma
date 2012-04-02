class AuthController < ApplicationController
  def login
    session[:user_id]=nil
    if request.post?
      user = User.find_by_name(params[:name]).authenticate(params[:password])
      if user
        session[:user_id]=user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to (uri || :root)
      else
        flash.now[:notice] = "Invalid login/password"
      end
    end
  end

  def logout
    reset_session
    flash[:notice] = "Logged out"
    redirect_to :login
  end
end
