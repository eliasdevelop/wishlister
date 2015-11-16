module Features
  def sign_in_as(user)
    session[:user_id] = user.id
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end