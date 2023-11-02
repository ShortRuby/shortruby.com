# frozen_string_literal: true

module Subscribers
  class Create
    include Dry::Monads[:result]

    def initialize(subscriber:, list:, unsubscribe_url:)
      @subscriber = subscriber
      @list = list
      @unsubscribe_url = unsubscribe_url
    end

    def call
      return Failure(subscriber) if validate.failure?

      if subscriber.save
        subscriber.subscribe(list)
        send_notification

        return Success(subscriber)
      end

      Failure(subscriber)
    end

    private

      attr_reader :subscriber, :list, :unsubscribe_url

      def validate = Validate.new(subscriber:, list:).call

      def send_notification = SubscribedNotificationMailer.with(to:, unsubscribe_url:).subscribed.deliver_later

      def to = subscriber.email
  end
end
