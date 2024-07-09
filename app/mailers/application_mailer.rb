# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "hello@shortruby.com"
  layout "mailer"

  def from = "hello@shortruby.com"
end
