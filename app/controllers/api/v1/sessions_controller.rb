# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Api::V1::BaseController
      
      skip_before_action :authenticate_request

      def create
        command = Commands::User::Authenticate.call(
          email: user_params[:email],
          password: user_params[:password],
          ip: request.remote_ip
        )

        token = jwt_encode(user_id: command.user_id)
        render json: { token: token }, status: :ok

      rescue ActiveModel::ValidationError
        render json: { error: 'unauthorized' }, status: :unauthorized
      end

      private

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
