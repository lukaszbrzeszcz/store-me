# frozen_string_literal: true

module Events
  module Container
    class Created < Events::Container::BaseEvent
      payload_attributes :name, :barcode, :user_id, :category, :size, :is_item, :image_id

      def apply(container)
        container.name = name
        container.barcode = barcode
        container.user_id = user_id
        container.category = category
        container.size = size
        container.is_item = is_item
        container.image_id = image_id

        container
      end
    end
  end
end
