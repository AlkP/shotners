class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, flash: { user_ok: "You are sign up !" }
    else
      render "new"
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update(params[:user])
      redirect_to root_path
    else
      render 'edit'
    end
  end

end
