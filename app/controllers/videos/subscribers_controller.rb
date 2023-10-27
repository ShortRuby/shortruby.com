# frozen_string_literal: true

class Videos::SubscribersController < ApplicationController
  before_action :check_existing_subscriber, only: [:create]

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      @subscriber.subscribe("video_updates")
      flash[:notice] = "You've subscribed successfully!"
    else
      flash[:error] = "There was a problem subscribing you!"
      redirect_to page_path("videos")
    end
  end

  private

    def check_existing_subscriber
      if Subscriber.exists?(email: subscriber_params["email"])
        flash[:notice] = "You are already subscribed!"
        redirect_to page_path("videos")
      end
    end

    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
end
