# frozen_string_literal: true

class Subscriber < ApplicationRecord
  has_subscriptions
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
