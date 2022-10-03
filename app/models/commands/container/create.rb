# frozen_string_literal: true

module Commands
  module Container
    class Create
      include Lib::Command

      attributes :name, :user_id, :category, :size, :is_item, :image_id

      validates :name, presence: true

      private

      def build_event
        Events::Container::Created.new(
          payload: {
            name: name,
            barcode: barcode,
            category: category,
            size: size,
            is_item: is_item,
            user_id: user_id,
            image_id: image_id,
          }
        )
      end

      def barcode
        @barcode ||= SecureRandom.hex(8)
      end
    end
  end
end
