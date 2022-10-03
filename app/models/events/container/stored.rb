# frozen_string_literal: true

module Events
  module Container
    class Stored < Events::Container::BaseEvent
      payload_attributes :container_id, :new_container_id

      def apply(container)
        container.container_id = new_container_id

        container
      end
    end
  end
end
