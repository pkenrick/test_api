module SessionsHelper

  # logs in the specified user
  def login(user)
    session[:user_id] = user.id
  end

  # returns the current logged in user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # logs out the current user
  def logout
    session.delete(:user_id)
  end
end
