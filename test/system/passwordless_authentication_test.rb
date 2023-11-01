# frozen_string_literal: true

require "application_system_test_case"

class PasswordlessAuthenticationTest < ApplicationSystemTestCase
  test "visiting the sign in page" do
    visit ready_room_sign_in_path

    assert_selector "h2", text: "Sign in to ReadyRoom"
  end

  test "sign in with valid email" do
    visit ready_room_sign_in_path
    fill_in "passwordless[email]", with: "hello@example.com"
    click_button "Sign in"

    assert_text "We've sent you an email with a secret token"
  end

  test "sign in with invalid email" do
    visit ready_room_sign_in_path
    fill_in "passwordless[email]", with: "doesnotexist@example.com"
    click_button "Sign in"

    assert_text "We couldn't find a user with that email address"
  end

  test "sign out" do
    user = admins(:one)
    session = Passwordless::Session.create!(authenticatable: user)
    visit root_path

    assert_text "Community, learning, building"

    visit confirm_admins_sign_in_path(session, session.token)

    assert_text "Authenticated"

    click_button "sign_out_button"

    assert_text "Signed out successfully"
  end
end
