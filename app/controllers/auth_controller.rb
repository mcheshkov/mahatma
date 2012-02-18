class AuthController < ApplicationController
  def login
    session[:login_id]=nil
    if request.post?
      login = Login.authenticate(params[:name],params[:password])
      if login
        session[:login_id]=login.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to (uri || :root)
      else
        flash.now[:notice] = "Invalid login/password"
      end
    end
  end

  def logout
    session[:login_id]=nil
    flash[:notice] = "Logged out"
    redirect_to :login
  end
end
