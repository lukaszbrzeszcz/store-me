# frozen_string_literal: true

module Commands
  module User
    class Authenticate
      include Lib::Command

      attributes :email, :password, :ip
      validate :authenticated?

      private

      def build_event
        Events::User::Authenticated.new(
          payload: {
            user_id: user.id,
            email: email,
            ip: ip
          }
        )
      end

      def authenticated?
        return if user.present? && user.authenticate(password)

        errors.add(:user, "Doesn't exist")
      end

      def user
        @user ||= ::User.find_by(email: email)
      end
    end
  end
end
