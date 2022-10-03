# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def new
    @user = User.new
  end

  def create
    command = Commands::User::Authenticate.call(email: user_params[:email], password: user_params[:password], ip: request.remote_ip)

    session[:user_id] = command.user_id
    redirect_to root_path
  rescue ActiveModel::ValidationError
    flash[:error] = command.errors.full_messages
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
