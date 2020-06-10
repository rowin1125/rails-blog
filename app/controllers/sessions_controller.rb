class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'Successfully logged in'
      redirect_to user
    else
      flash.now[:alert] = 'There was something wrong with you login'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Log out'
    redirect_to root_path
  end
end
