# frozen_string_literal: true

class Videos::UnsubscribesController < ApplicationController
  def new; end

  def destroy
    case destroy_subscriber.call
    when Dry::Monads::Success
      flash[:notice] = "You have been unsubscribed from the mailing list."
      redirect_to page_path("videos")
    else
      flash[:error] =
        "Cannot find your email address or cannot remove your subscription! Please contact support@shortruby.com to remove it"
      redirect_to new_videos_unsubscribe_path
    end
  end

  private

    def email = params.require(:subscriber).permit(:email).fetch(:email)

    def destroy_subscriber = Subscribers::Delete.new(email:)
end
