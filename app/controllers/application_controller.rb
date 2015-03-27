class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from StandardError do |e|
    render json: {
      error: e.message,
      location: e.backtrace.first
      #FIXME ?backtrace: e.backtrace # if in development?
    }, status: 500
  end

  def after_sign_in_path_for(resource)
    "https://quiet-refuge-3512.herokuapp.com/index2.html"
  end
end
