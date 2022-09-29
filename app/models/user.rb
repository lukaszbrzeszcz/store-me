# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :events, class_name: 'Events::User::BaseEvent'
end
