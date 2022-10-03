# frozen_string_literal: true

class Container < ApplicationRecord
  has_many :events, class_name: 'Events::Container::BaseEvent'
  belongs_to :image, optional: true
  belongs_to :container, optional: true
  has_many :containers

  trigger.before(:insert) do
    'UPDATE users SET containers_count = containers_count + 1 WHERE id = NEW.user_id;'

    'UPDATE containers SET containers_count = containers_count + 1 WHERE id = NEW.container_id'
  end

  trigger.before(:update).of(:user_id) do
    <<-SQL
      UPDATE users
        SET containers_count = containers_count + 1
      WHERE id = NEW.user_id;
      UPDATE users
        SET containers_count = containers_count - 1
      WHERE id = OLD.user_id;
    SQL
  end

  trigger.before(:update).of(:container_id) do
    <<-SQL
      UPDATE containers
        SET containers_count = containers_count + 1
      WHERE id = NEW.container_id;
      UPDATE containers
        SET containers_count = containers_count - 1
      WHERE id = OLD.container_id;
    SQL
  end

  trigger.before(:delete) do
    'UPDATE users SET containers_count = containers_count - 1 WHERE id = OLD.user_id;'

    'UPDATE containers SET containers_count = containers_count - 1 WHERE id = OLD.container_id;'
  end

  enum size: {
    small: 'small',
    medium: 'medium',
    large: 'large',
  }

  enum category: {
    furniture: 'furniture',
    box: 'box',
    bag: 'bag',
  }
end
