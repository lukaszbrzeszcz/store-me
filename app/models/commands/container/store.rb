# frozen_string_literal: true

module Commands
  module Container
    class Store
      include Lib::Command

      attributes :container_id, :new_container_id

      private

      def build_event
        Events::Container::Stored.new(
          payload: {
            container_id: container_id,
            new_container_id: new_container_id
          }
        )
      end
    end
  end
end
