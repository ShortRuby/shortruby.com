# frozen_string_literal: true

module Subscribers
  class Validate
    include Dry::Monads[:result]

    def initialize(subscriber:, list:)
      @subscriber = subscriber
      @list = list
    end

    def call
      if subscription?
        subscriber.errors.add(:base, "You are already subscribed!")
        return Failure(subscriber)
      end

      if subscriber.valid?
        return Success(subscriber)
      end

      Failure(subscriber)
    end

    private

      attr_reader :subscriber, :list

      def subscription?
        subscriber.mailkick_subscriptions.exists?(list:)
      end
  end
end
