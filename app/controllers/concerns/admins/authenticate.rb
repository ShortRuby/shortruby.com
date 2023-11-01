# frozen_string_literal: true

module Admins
  module Authenticate
    extend ActiveSupport::Concern
    include Passwordless::ControllerHelpers

    private

      def authenticate_admin!
        return if current_admin

        redirect_to main_app.root_path, flash: { error: "This is a restricted area!" }
      end
  end
end
