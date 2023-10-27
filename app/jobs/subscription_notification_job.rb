# frozen_string_literal: true

require "postmark"

class SubscriptionNotificationJob < ApplicationJob
  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(subscriber, url)
    client = Postmark::ApiClient.new(ENV.fetch("POSTMARK_API_KEY", nil))

    client.deliver_with_template(
      { from: "hello@shortruby.com",
        to: subscriber.email,
        template_alias: "welcome",
        template_model: {
          "product_url" => "https://shortruby.com",
          "product_name" => "ShortRuby Video Podcasts",
          "action_url" => url,
          "support_email" => "hello@shortruby.com",
          "company_name" => "Short Ruby",
          "company_address" => "Sibiu, Romania"
        } }
    )
  end
end
