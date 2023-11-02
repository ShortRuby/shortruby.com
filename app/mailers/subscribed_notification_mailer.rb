# frozen_string_literal: true

require "postmark-rails/templated_mailer"

class SubscribedNotificationMailer < ApplicationMailer
  def subscribed
    to = params[:to]
    unsubscribe_url = params[:unsubscribe_url]
    self.template_model = { unsubscribe_url: }

    mail(to:, from:)
  end
end
