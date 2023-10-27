# frozen_string_literal: true

class SubscribedNotificationMailer < ApplicationMailer
  def notify(subscriber)
    @subscriber = subscriber
    mail to: subscriber.email, subject: "You've subscribed to ShortRuby Videos!"
  end
end
