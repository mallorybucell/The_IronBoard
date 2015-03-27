class ApiController < ActionController::Base
  before_action :hardcode_json_format
  before_action :authenticate_token!

  rescue_from StandardError do |e|
    render json: {
      error: e.message,
      location: e.backtrace.first
      #FIXME ?backtrace: e.backtrace # if in development?
    }, status: 500
  end

  rescue_from Token::Invalid do |e|
    render json: { error: "Token invalid" }, status: 404
  end

private

  def hardcode_json_format
    request.format = :json
  end

  def authenticate_token!
    raise Token::Invalid unless Rack::Utils.
      secure_compare(params[:token], ENV['IRONBOARD_API_TOKEN']) && Token.find_by(key: params[:token]).disabled? == false
      # :all, :conditions => [:key => ?, params[:token]])
  end

end

