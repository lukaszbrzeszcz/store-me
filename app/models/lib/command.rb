# frozen_string_literal: true

module Lib
  module Command
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations
    end

    class_methods do
      def call(**args)
        new(**args).call
      end

      def attributes(*args)
        attr_reader(*args)

        initialize_method_arguments = args.map { |arg| "#{arg}:" }.join(', ')
        initialize_method_body = args.map { |arg| "@#{arg} = #{arg}" }.join(";")

        class_eval <<~CODE
          def initialize(#{initialize_method_arguments})
            #{initialize_method_body}
            after_initialize
          end
        CODE
      end
    end

    def call
      return nil if event.nil?
      raise 'The event should not be persisted at this stage!' if event.persisted?

      validate!
      execute!

      event
    end

    def validate!
      valid? || raise(ActiveRecord::RecordInvalid, self)
    end

    def event
      @event ||= build_event
    end

    private

    def execute!
      event.save!
    end

    def build_event
      raise NotImplementedError
    end

    def after_initialize
    end
  end
end
