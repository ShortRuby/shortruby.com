# frozen_string_literal: true

require "test_helper"

class SubscribedEmailNotificationJobTest < ActiveJob::TestCase
  attr_reader :unsubscribe_url, :email

  setup do
    @unsubscribe_url = "https://example.com/unsubscribe"
    @email = "user@example.com"
  end

  test "enqueues the job" do
    assert_enqueued_with(job: SubscribedEmailNotificationJob) do
      SubscribedEmailNotificationJob.perform_later
    end
  end

  test "performs the job and calls subscribers notify" do
    mock_notifier = mock
    mock_notifier.expects(:send).once

    Subscribers::Notify.expects(:new).with(unsubscribe_url:, email:).returns(mock_notifier)

    SubscribedEmailNotificationJob.perform_now(email, unsubscribe_url)
  end

  test "job in default queue" do
    assert_equal "default", SubscribedEmailNotificationJob.queue_name
  end
end
