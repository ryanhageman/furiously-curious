# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :current_visitor

  def current_visitor
    @current_visitor = current_user || GuestUser.new
  end
end
