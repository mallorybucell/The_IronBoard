class StaticPagesController < ApplicationController
  def home
  end

  def new
  end

  def create
    EmailWorker.perform_async(current_user.id, static_page_params)
    flash["success"] = "Your email has been sent!"
    redirect_to new_invite_path
  end

private
  def static_page_params
    params.permit(:email, :name)
  end
end
