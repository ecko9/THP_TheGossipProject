module SessionsHelper

  def current_user
    if session[:user_id] != nil
      return User.find(session[:user_id])
    else
      return nil
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    if session[:user_id] != nil
      return true
    else
      return false
    end  
  end

end
