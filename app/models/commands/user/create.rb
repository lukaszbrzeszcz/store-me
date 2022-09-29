# frozen_string_literal: true

module Commands
  module User
    class Create
      include Lib::Command

      attributes :name, :email, :password

      validates :name, presence: true, length: { in: 4..25 }
      validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
      validate :email_uniq?

      private

      def build_event
        Events::User::Created.new(
          payload: {
            name: name,
            email: email,
            password: encrypted_password
          }
        )
      end

      def encrypted_password
        BCrypt::Password.create(password)
      end

      def email_uniq?
        return unless ::User.exists?(email: email)
        errors.add(:email, 'already exists')
      end
    end
  end
end
