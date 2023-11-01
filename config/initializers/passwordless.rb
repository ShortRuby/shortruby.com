# frozen_string_literal: true

Passwordless.configure do |config|
  config.default_from_address = "hello@shortruby.com"
  config.parent_mailer = "ActionMailer::Base"
  config.restrict_token_reuse = false
  config.token_generator = lambda do |_session|
    segment = -> { SecureRandom.hex(2) }
    "#{segment.call}-#{segment.call}-#{segment.call}".upcase
  end

  config.expires_at = lambda { 2.weeks.from_now }
  config.timeout_at = lambda { 10.minutes.from_now }

  config.redirect_back_after_sign_in = true
  config.redirect_to_response_options = {}
  config.success_redirect_path = "/ready_room/dashboard"
  config.failure_redirect_path = "/" # After a sign in fails
  config.sign_out_redirect_path = "/" # After a user signs out
end
