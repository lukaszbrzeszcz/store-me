# frozen_string_literal: true

class Image < ApplicationRecord
  include ImageUploader::Attachment(:image)
end
