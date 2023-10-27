# Preview all emails at http://localhost:3000/rails/mailers/subscribed_notification_mailer
class SubscribedNotificationMailerPreview < ActionMailer::Preview
  def test_notify
    if Subscriber.count == 0
      subscriber = Subscriber.create(email: "test@example.com")
    end

    SubscribedNotificationMailer.notify(Subscriber.first)
  end
end
