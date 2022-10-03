# frozen_string_literal: true

module Api
  module V1
    class ContainersController < Api::V1::BaseController

      def index
        @containers = ContainerRepository.all_root(user_id: Current.user.id)

        render json: @containers
      end
    end
  end
end
