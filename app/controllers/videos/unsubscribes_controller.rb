# frozen_string_literal: true

class Videos::UnsubscribesController < ApplicationController
  def new; end

  def destroy
    @subscriber = Subscriber.find_by(email: subscriber_params[:email])
    if @subscriber
      @subscriber.destroy
      flash[:notice] = "You have been unsubscribed from the mailing list."
      redirect_to page_path("videos")
    else
      flash[:error] = "Cannot find your email address!"
      redirect_to new_videos_unsubscribe_path
    end
  end

  private

    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
end
