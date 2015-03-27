require 'mandrill'

class StaticPagesController < ApplicationController
  def home
  end

  def new
  end

  def create
    m = Mandrill::API.new(ENV.fetch "MANDRILL_APIKEY")
    m.messages.send(current_user.generate_invite_email(static_page_params))
    flash["success"] = "Your email has been sent!"
    redirect_to new_invite_path
  end

private
  def static_page_params
    params.permit(:email, :name)
  end
end
