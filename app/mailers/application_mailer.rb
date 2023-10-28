# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "hello@shortruby.com"
  layout "mailer"
end
