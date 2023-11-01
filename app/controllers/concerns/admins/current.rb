# frozen_string_literal: true

module Admins
  module Current
    extend ActiveSupport::Concern
    include Passwordless::ControllerHelpers

    included do
      helper_method :current_admin
    end

    def current_admin = @_current_admin ||= authenticate_by_session(Admin)
  end
end
