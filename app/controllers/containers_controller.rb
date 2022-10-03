# frozen_string_literal: true

class ContainersController < ApplicationController
  def new
    @container = Container.new
  end

  def create
    image = nil
    if container_params[:image]
      image = Image.create(image: container_params[:image][:image])
    end

    command = Commands::Container::Create.call(
      user_id: Current.user.id,
      name: container_params[:name],
      category: container_params[:category],
      size: container_params[:size],
      is_item: container_params[:is_item],
      image_id: image.present? ? image.id : nil
    )

    redirect_to containers_path
  end

  def index
    @all_containers = ContainerRepository.no_items(user_id: Current.user.id)
    @containers = ContainerRepository.all_root(user_id: Current.user.id)
  end

  def show
    @all_containers = ContainerRepository.no_items(user_id: Current.user.id)
    @container = ContainerRepository.with_containers(user_id: Current.user.id, root_id: params[:id])
  end

  def store_container
    command = Commands::Container::Store.call(
      container_id: params[:id],
      new_container_id: store_container_params[:container_id]
    )

    redirect_back fallback_location: containers_path
  end

  private

  def container_params
    params.require(:container).permit(:name, :category, :size, :is_item, image: [:image])
  end

  def store_container_params
    params.require(:container).permit(:container_id)
  end
end
