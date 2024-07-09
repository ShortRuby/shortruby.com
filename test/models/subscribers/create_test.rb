# frozen_string_literal: true

require "test_helper"

module Subscribers
  class CreateTest < ActiveSupport::TestCase
    attr_reader :list, :unsubscribe_url

    setup do
      @list = "video_updates"
      @already_subscribed_subscriber = subscribers(:already_subscribed)  # Assuming you have a fixture or factory
      @unsubscribe_url = "http://example.com/unsubscribe"
    end

    test "should return success and send notification when subscriber is valid and not already subscribed" do
      email = "test@example.com"
      SubscribedEmailNotificationJob.
        expects(:perform_later).
        with(email, unsubscribe_url).
        once.
        returns(stub(deliver_later: true))
      subscriber = Subscriber.new(email:)

      result = Create.new(subscriber:, list:, unsubscribe_url:).call

      assert_predicate result, :success?
    end

    test "should return failure when validation fails" do
      subscriber = Subscriber.new(email: "invalid_email")
      result = Create.new(subscriber:, list:, unsubscribe_url:).call

      assert_predicate result, :failure?
    end

    test "should return failure when subscriber is already subscribed" do
      subscriber = subscribers(:already_subscribed)
      result = Create.new(subscriber:, list:, unsubscribe_url:).call

      assert_predicate result, :failure?
    end

    test "should return failure when saving subscriber fails" do
      subscriber = Subscriber.new(email: "test@example.com")
      subscriber.stubs(:save).returns(false)

      result = Create.new(subscriber:, list:, unsubscribe_url:).call

      assert_predicate result, :failure?
    end
  end
end
