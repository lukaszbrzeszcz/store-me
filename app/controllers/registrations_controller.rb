# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user

  def new
    @user = User.new
  end

  def create
    Commands::User::Create.call(name: user_params[:name], email: user_params[:email], password: user_params[:password])

    flash[:notice] = 'User created successfully'
    redirect_to root_path
  rescue ActiveModel::ValidationError
    flash[:error] = 'User registration failed!'
    @user = User.new
    render 'new'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
