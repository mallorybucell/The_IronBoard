class UserGame < ActiveRecord::Base
  belongs_to :user
  belongs_to :game


  validates_uniqueness_of :user, scope: :game

  def self.update_wins winner
    entry = self.last
    if User.find(entry.user_id).username == winner
      entry.update(winner: true)
    else
      entry.update(winner: false)
    end
  end

  def self.generate_user_games number
    number.times do |u|
      ug = UserGame.new
      ug.user_id = User.all.pluck(:id).sample
      ug.game_id = Game.all.pluck(:id).sample
      ug.winner = [true, false].sample
      ug.save!
    end
  end

end
