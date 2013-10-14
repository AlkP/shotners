class SessionsController < ApplicationController
  def new
  end

  def create
    user =  User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    #render "shotners/index"
    redirect_to root_url, :notice => "Logged out! Refresh page!"
  end

end
