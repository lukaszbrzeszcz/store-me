# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    event = Commands::User::Authenticate.call(email: user_params[:email], password: user_params[:password], ip: request.remote_ip)

    session[:user_id] = event.user_id
    redirect_to root_path
  rescue ActiveModel::ValidationError
    flash[:error] = event.errors.full_messages
    @user = User.new
    render 'new'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
