class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      log_in(@user)
      puts params[:user][:stay_connect]
      if params[:user][:stay_connect] == 1
        remember_him(@user)
      end
      puts "***** Connection OK"
      redirect_to home_path
    else
      puts "***** Connection FAUX"
      #flash.now[:danger] = 'Invalid email/password combination'
      render new_session_path
    end
  end

  def destroy
    @user = current_user
    log_out(@user)
    redirect_to home_path
  end
  
end
