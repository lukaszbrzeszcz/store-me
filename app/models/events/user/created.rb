# frozen_string_literal: true

module Events
  module User
    class Created < Events::User::BaseEvent
      payload_attributes :name, :email, :password

      def apply(user)
        user.name = name
        user.email = email
        user.password_digest = password
        
        user
      end
    end
  end
end
