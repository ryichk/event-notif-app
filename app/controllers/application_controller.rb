# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate
  helper_method :logged_in?, :current_user

  rescue_from Exception, with: :error500
  rescue_from ActiveRecord::RecordNotFound,
              ActionController::RoutingError, with: :error404

  private

  def logged_in?
    !!current_user
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end

  def authenticate
    return if logged_in?

    redirect_to root_path, alert: 'ログインしてください'
  end

  def error404(_error)
    render 'error404', status: :not_found, formats: [:html]
  end

  def error500(error)
    logger.error [error, *error.backtrace].join('\n')
    render 'error500', status: :internal_server_error, formats: [:html]
  end
end
