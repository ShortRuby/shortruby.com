# frozen_string_literal: true

class Videos::SubscribersController < ApplicationController
  SUBSCRIBE_TO_LIST = "video_updates"

  def create
    case subscribers_create.call
    when Dry::Monads::Success
      flash.now[:notice] = "You've subscribed successfully!"
    when Dry::Monads::Failure
      flash.now[:error] = "There was a problem subscribing you! #{subscriber.errors.full_messages.join(', ')}"
    end
  end

  private

    def subscribers_create = Subscribers::Create.new(subscriber:, list:, unsubscribe_url:)

    def unsubscribe_url = new_videos_unsubscribe_url

    def subscriber = @_subscriber ||= Subscriber.new(subscriber_params)

    def list = SUBSCRIBE_TO_LIST

    def subscriber_params = params.require(:subscriber).permit(:email)
end
