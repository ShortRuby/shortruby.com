# frozen_string_literal: true

class SubscribedEmailNotificationJob < ApplicationJob
  queue_as :default

  # Sends the notification email to the subscriber
  # @param email [String] The email address of the subscriber
  # @param unsubscribe_url [String] The URL to unsubscribe from the mailing list
  # @return [void]
  def perform(email, unsubscribe_url)
    Subscribers::Notify.new(email:, unsubscribe_url:).send
  end
end
