# frozen_string_literal: true

class ContainerRepository
  def self.all_root(user_id:)
    Container.includes(:image).where(user_id: user_id, container_id: nil)
  end

  def self.with_containers(user_id:, root_id:)
    Container.find_by(user_id: user_id, id: root_id)
  end

  def self.no_items(user_id:)
    Container.where(user_id: user_id, is_item: false)
  end
end
