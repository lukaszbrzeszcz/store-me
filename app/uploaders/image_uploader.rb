# frozen_string_literal: true
require_relative '../../config/initializers/shrine'

class ImageUploader < Shrine
  plugin :determine_mime_type
end
