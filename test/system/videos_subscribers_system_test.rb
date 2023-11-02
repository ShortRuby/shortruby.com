# frozen_string_literal: true

require "application_system_test_case"

class VideosSubscribersSystemTest < ApplicationSystemTestCase
  test "visiting the videos page" do
    visit page_path("videos")

    assert_text "Sign up to get updates when I launch."
  end

  test "subscribe with valid email" do
    visit page_path("videos")

    fill_in "Email address", with: "test@example.com"
    click_button "Subscribe"

    assert_text "You've subscribed successfully!"
  end

  test "subscribe with duplicate email" do
    existing_subscriber = subscribers(:already_subscribed)

    visit page_path("videos")

    fill_in "Email address", with: existing_subscriber.email
    click_button "Subscribe"

    assert_text "There was a problem subscribing you!"
  end
end
