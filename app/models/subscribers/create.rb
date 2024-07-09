# frozen_string_literal: true

module Subscribers
  class Create
    include Dry::Monads[:result]

    # @param subscriber [Subscriber] An non-persisted instance of the Subscriber model
    # @param list [String] The mailing list to subscribe the subscriber to
    # @param unsubscribe_url [String] The URL to unsubscribe from the mailing list
    def initialize(subscriber:, list:, unsubscribe_url:)
      @subscriber = subscriber
      @list = list
      @unsubscribe_url = unsubscribe_url
    end

    # @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure] The result of the operation
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

      # @return [Subscriber] An instance of the Subscriber model
      attr_reader :subscriber

      # @return [String] The mailing list to subscribe the subscriber to
      attr_reader :list

      # @return [String] The URL to unsubscribe from the mailing list
      attr_reader :unsubscribe_url

      # @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure] The result of the validation
      def validate = Validate.new(subscriber:, list:).call

      # @return [void] Sends the notification email to the subscriber
      def send_notification = SubscribedEmailNotificationJob.perform_later(email, unsubscribe_url)

      # @return [String] The email address of the subscriber
      def email = subscriber.email
  end
end
