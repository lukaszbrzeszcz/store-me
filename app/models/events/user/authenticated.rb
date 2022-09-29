# frozen_string_literal: true

module Events
  module User
    class Authenticated < Events::User::BaseEvent
      payload_attributes :user_id, :email, :ip

      def apply(user)
        user.sign_in_count += 1
        user.last_sign_in_ip = user.current_sign_in_ip
        user.last_sign_in_at = user.current_sign_in_at
        user.current_sign_in_ip = ip
        user.current_sign_in_at = Time.zone.now

        user
      end
    end
  end
end
