# frozen_string_literal: true

require "application_system_test_case"

class Videos::UnsubscribesSystemTest < ApplicationSystemTestCase
  setup do
    @subscriber = subscribers(:already_subscribed)
  end

  test "successfully unsubscribes a user" do
    visit new_videos_unsubscribe_path

    fill_in "subscriber_email", with: @subscriber.email
    click_button "Unsubscribe"

    assert_current_path page_path("videos")
    assert_text "You have been unsubscribed from the mailing list."

    assert_nil Subscriber.find_by(email: @subscriber.email)
  end

  test "unsuccessfully unsubscribes a user with email not in system" do
    visit new_videos_unsubscribe_path

    fill_in "subscriber_email", with: "not_exist@example.com"
    click_button "Unsubscribe"

    assert_current_path new_videos_unsubscribe_path
    assert_text "Cannot find your email address or cannot remove your subscription! Please contact support@shortruby.com to remove it"
  end
end
