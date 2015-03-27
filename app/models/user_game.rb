class UserGame < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def self.update_wins winner
    entry = self.last
    if User.find(entry.user_id).username == winner
      entry.update(winner: true)
    else
      entry.update(winner: false)
    end
  end

end
