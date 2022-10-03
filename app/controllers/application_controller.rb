class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :authenticate_user

  def set_current_user
    if session[:user_id]
      Current.user = User.find(session[:user_id])
    end
  end

  def authenticate_user
    redirect_to login_path unless Current.user.present?
  end
end
