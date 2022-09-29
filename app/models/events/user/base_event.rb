# frozen_string_literal: true

module Events
  module User
    class BaseEvent < Events::BaseEvent
      self.table_name = 'user_events'

      belongs_to :user, class_name: '::User'
    end
  end
end
