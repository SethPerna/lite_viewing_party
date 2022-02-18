class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @user = User.find(session[:id]) if session[:user_id]
  end
end
