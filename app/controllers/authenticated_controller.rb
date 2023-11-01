# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include Admins::Authenticate
  before_action :authenticate_admin!
end
