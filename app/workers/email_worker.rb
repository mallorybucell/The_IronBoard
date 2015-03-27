class EmailWorker < ActiveJob::Base
  include Sidekiq::Worker

  def perform(user_id, static_page_params)
    u = User.find(user_id)
    u.send_invite_email(static_page_params)
  end
end