# frozen_string_literal: true

require "brevo"

Brevo.configure do |config|
  config.api_key["api-key"] = ENV.fetch("BREVO_API_KEY")
end
