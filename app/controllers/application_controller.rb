# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Admins::Current
end
