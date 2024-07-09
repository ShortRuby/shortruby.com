# frozen_string_literal: true

require "mailersend-ruby"

module Subscribers
  class Notify
    FROM_EMAIL = "hello@shortruby.com"
    TEMPLATE_ID = "yzkq340xerx4d796"
    SUBJECT = "Short Ruby Subscribed to Video Updates"

    # @param email [String] The email address of the subscriber
    # @param unsubscribe_url [String] The URL to unsubscribe from the mailing list
    def initialize(email:, unsubscribe_url:)
      @email = email
      @unsubscribe_url = unsubscribe_url
    end

    # Sends the notification email to the subscriber
    # @return [void]
    def send
      mailer_send = new_mailer_send
      mailer_send.add_recipients("email" => email)

      personalization = {
        email: email,
        data: {
          unsubscribe_url:
        }
      }

      mailer_send.add_personalization(personalization)

      mailer_send.send
    end

    private

      # @return [String] The email address of the subscriber
      attr_reader :email

      # @return [String] The URL to unsubscribe from the mailing list
      attr_reader :unsubscribe_url

      # Returns a new instance of Mailersend::Email
      # @return [Mailersend::Email]
      def new_mailer_send
        client = Mailersend::Client.new(ENV.fetch("MAILERSEND_API_KEY"))
        mailer_send = Mailersend::Email.new(client)
        mailer_send.add_from("email" => FROM_EMAIL, "name" => "Short Ruby")
        mailer_send.add_template_id(TEMPLATE_ID)
        mailer_send.add_subject(SUBJECT)

        mailer_send
      end
  end
end
