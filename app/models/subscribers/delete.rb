# frozen_string_literal: true

module Subscribers
  class Delete
    include Dry::Monads[:result]

    def initialize(email:)
      @email = email
      @subscriber = Subscriber.find_by(email:)
    end

    def call
      return Failure(email) unless subscriber

      Subscriber.transaction do
        subscriber.mailkick_subscriptions.destroy_all
        subscriber.destroy
      end

      Success(email)
    end

    private

      attr_reader :email, :subscriber
  end
end
