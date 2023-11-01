# frozen_string_literal: true

require "test_helper"

class AdminTest < ActiveSupport::TestCase
  test "invalid admin without email" do
    admin = Admin.new

    refute_predicate admin, :valid?
  end

  test "valid admin with email" do
    admin = Admin.new(email: "test@example.com")

    assert_predicate admin, :valid?
  end
end
