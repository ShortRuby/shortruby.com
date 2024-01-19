# frozen_string_literal: true

class Videos::SubscribersController < ApplicationController
  SUBSCRIBE_TO_LIST = "video_updates"

  def create
    case subscribers_create.call
    when Dry::Monads::Success
      add_success_message
    when Dry::Monads::Failure
      add_error_message
    end
  end

  private

    def subscribers_create = Subscribers::Create.new(subscriber:, list:, unsubscribe_url:)

    def add_success_message = flash.now[:notice] = t(".success_message")

    def add_error_message = flash.now[:error] = t(".error_message", error_messages:)

    def error_messages = subscriber.errors.full_messages.join(", ")

    def unsubscribe_url = new_videos_unsubscribe_url

    def subscriber = @_subscriber ||= Subscriber.new(subscriber_params)

    def list = SUBSCRIBE_TO_LIST

    def subscriber_params = params.require(:subscriber).permit(:email)
end
