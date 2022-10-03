# frozen_string_literal: true

module Events
  module Container
    class BaseEvent < Events::BaseEvent
      self.table_name = 'container_events'

      belongs_to :container, class_name: '::Container'
    end
  end
end
