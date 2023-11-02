# frozen_string_literal: true

require "test_helper"

class SubscriberTest < ActiveSupport::TestCase
  test "invalid admin without email" do
    subscriber = Subscriber.new

    refute_predicate subscriber, :valid?
  end

  test "valid admin with email" do
    subscriber = Subscriber.new(email: "test@example.com")

    assert_predicate subscriber, :valid?
  end

  test "cannot add a new email if it already exists" do
    existing_subscriber = subscribers(:already_subscribed)

    new_subscriber = Subscriber.new(email: existing_subscriber.email)

    refute_predicate new_subscriber, :valid?
  end
end
