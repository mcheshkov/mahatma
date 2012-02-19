class AuthController < ApplicationController
  def login
    session[:user_id]=nil
    if request.post?
      user = User.authenticate(params[:name],params[:password])
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
    session[:user_id]=nil
    flash[:notice] = "Logged out"
    redirect_to :login
  end
end
