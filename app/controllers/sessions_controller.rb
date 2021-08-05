class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      puts "***** Connection OK"
      redirect_to home_path
    else
      puts "***** Connection FAUX"
      #flash.now[:danger] = 'Invalid email/password combination'
      render sessions_new_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to home_path
  end
end
