# frozen_string_literal: true

require "test_helper"

module Subscribers
  class ValidateTest < ActiveSupport::TestCase
    setup do
      @list = "video_updates"
    end

    test "should return success when subscriber is valid and not already subscribed" do
      subscriber = Subscriber.new(email: "test@example.com")
      result = Validate.new(subscriber: subscriber, list: @list).call

      assert_predicate result, :success?
    end

    test "should return failure when subscriber is already subscribed" do
      subscriber = subscribers(:already_subscribed)
      result = Validate.new(subscriber: subscriber, list: @list).call

      assert_predicate result, :failure?
      assert_includes subscriber.errors.full_messages, "You are already subscribed!"
    end

    test "should return failure when subscriber is invalid" do
      subscriber = Subscriber.new(email: "invalid_email")
      result = Validate.new(subscriber: subscriber, list: @list).call

      assert_predicate result, :failure?
      assert_includes subscriber.errors.full_messages, "Email is invalid"
    end
  end
end
