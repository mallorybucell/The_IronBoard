class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from StandardError do |e|
    render json: {
      error: e.message,
      location: e.backtrace.first
      #FIXME ?backtrace: e.backtrace # if in development?
    }, status: 500
  end

  def home
  end

end
