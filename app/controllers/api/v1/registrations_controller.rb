# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < BaseController

      skip_before_action :authenticate_request

      def create
        Commands::User::Create.call(
          name: user_params[:name],
          email: user_params[:email],
          password: user_params[:password]
        )

        render json: { message: 'created' }, status: :ok

      rescue ActiveModel::ValidationError
        render json: { error: 'unprocessable_entity' }, status: :unprocessable_entity
      end

      private

      def user_params
        params.permit(:name, :email, :password)
      end
    end
  end
end
