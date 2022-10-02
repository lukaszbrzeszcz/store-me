# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      include JsonWebToken

      before_action :authenticate_request

      def authenticate_request
        auth_header = request.headers['Authorization']
        return unless auth_header.present?

        *_, header = auth_header.split(' ')
        decoded = jwt_decode(header)
        
        Current.user = User.find(decoded[:user_id])
      end
    end
  end
end
