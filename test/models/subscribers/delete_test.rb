# frozen_string_literal: true

require "test_helper"

class Subscribers::DeleteTest < ActiveSupport::TestCase
  test "successfully deletes a subscriber" do
    existing_subscriber = subscribers(:already_subscribed)
    service = Subscribers::Delete.new(email: existing_subscriber.email)

    result = service.call

    assert_predicate result, :success?
    assert_nil Subscriber.find_by(email: existing_subscriber.email)
    assert_equal 0, Mailkick::Subscription.where(subscriber: existing_subscriber).count
  end

  test "fails when email is not present" do
    service = Subscribers::Delete.new(email: "not_exist@example.com")

    result = service.call

    assert_predicate result, :failure?
    refute_nil Subscriber.find_by(email: "test@example.com")
  end
end
