# frozen_string_literal: true

require "postmark-rails/templated_mailer"

class SubscribedNotificationMailer < ApplicationMailer
  include PostmarkRails::TemplatedMailerMixin

  def subscribed(to:, unsubscribe_url:)
    self.template_model = { unsubscribe_url: }

    mail(to:)
  end
end
