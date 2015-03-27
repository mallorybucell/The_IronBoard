class StaticPagesController < ApplicationController
  def home
  end

  def new
  end

  def create
    if current_user
      EmailWorker.perform_async(current_user.id, static_page_params)
      flash["success"] = "Your email has been sent!"
    else
      flash["error"] = "You must log in to use this feature."
    end
    redirect_to new_invite_path
  end

private
  def static_page_params
    params.permit(:name, user: :email)
  end
end
